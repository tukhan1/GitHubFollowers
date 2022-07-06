//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 31.03.2022.
//

import UIKit
import SnapKit

final class SearchVC: UIViewController {

    private let logoImageView = UIImageView(frame: .zero)
    private let usernameTextField = GFTextField(frame: .zero)
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    private var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    private func configure () {
        view.backgroundColor = .systemBackground

        view.addSubviews(logoImageView, usernameTextField, callToActionButton)

        usernameTextField.delegate = self

        logoImageView.image = Images.ghLogo

        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
    }

    @objc private func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username",
                                       message: "Please enter a username. We need to know who to look for 😅.",
                                       buttonTitle: "Ok")
            return
        }

        usernameTextField.resignFirstResponder()

        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    private func makeConstraints() {
        logoImageView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            maker.height.width.equalTo(view.snp.width).multipliedBy(0.5)
            maker.centerX.equalTo(view.snp.centerX)
        }

        usernameTextField.snp.makeConstraints { maker in
            maker.top.equalTo(logoImageView.snp.bottom).offset(50)
            maker.centerX.equalTo(view.snp.centerX)
            maker.height.equalTo(view.snp.height).multipliedBy(0.06)
            maker.width.equalTo(view.snp.width).multipliedBy(0.7)
        }

        callToActionButton.snp.makeConstraints { maker in
            maker.centerX.equalTo(view.snp.centerX)
            maker.height.equalTo(view.snp.height).multipliedBy(0.06)
            maker.width.equalTo(view.snp.width).multipliedBy(0.7)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
