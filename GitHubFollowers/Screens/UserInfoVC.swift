//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.06.2022.
//

import UIKit
import SnapKit

final class UserInfoVC: UIViewController {
    private var username: String = ""

    private let headerView: UIView = UIView(frame: .zero)

    private let itemViewOne: UIView = UIView(frame: .zero)
    private let itemViewTwo: UIView = UIView(frame: .zero)
    private let dateLabel: GFBodyLabel = GFBodyLabel(textAligment: .center)

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
        getUserInfo(for: username)
    }

    private func makeConstraints() {
        let supportViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        for supportView in supportViews {
            view.addSubview(supportView)

            supportView.snp.makeConstraints { make in
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(padding)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(padding)
            }
        }

        view.addSubview(dateLabel)

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(180)
        }

        itemViewOne.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(padding)
            make.height.equalTo(itemHeight)
        }

        itemViewTwo.snp.makeConstraints { make in
            make.top.equalTo(itemViewOne.snp.bottom).offset(padding)
            make.height.equalTo(itemHeight)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(itemViewTwo.snp.bottom).offset(padding)
            make.height.equalTo(18)
        }
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        doneButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func getUserInfo(for username: String) {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newUser):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: newUser), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: newUser), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: newUser), to: self.itemViewTwo)
                    self.dateLabel.text = "Created at \(newUser.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func add(childVC: UIViewController, to containerView: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addChild(childVC)
            containerView.addSubview(childVC.view)
            childVC.view.frame = containerView.bounds
            childVC.didMove(toParent: self)
        }
    }
}
