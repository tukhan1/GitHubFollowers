//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 31.03.2022.
//

import UIKit

class FavoritesListVC: UIViewController {

    private var favorites: [Follower] = []

    private let tableView: UITableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getFavorites()
    }

    private func getFavorites() {

        showLoadingView()

        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let favorites):
                if favorites.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "Add users to favorites to see them here", in: self.view)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.favorites = favorites
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }

    private func configure() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension FavoritesListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell

        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
}

extension FavoritesListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete else { return }

        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)

        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
