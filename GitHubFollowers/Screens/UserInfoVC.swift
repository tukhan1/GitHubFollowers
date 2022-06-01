//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.06.2022.
//

import UIKit

final class UserInfoVC: UIViewController {
    private var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        doneButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = doneButton
        
        getUserInfo(for: username)
        
    }
    
    private func getUserInfo(for username: String) {
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let newUser):
                print(newUser)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
