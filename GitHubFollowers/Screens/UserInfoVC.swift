//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.06.2022.
//

import UIKit
import SnapKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

final class UserInfoVC: GFDataLoadingVC {

    weak var delegate: UserInfoVCDelegate?

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

    private func configure() {
        view.backgroundColor = .systemBackground

        view.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel, dateLabel)

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    private func makeConstraints() {

        let supportViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        for supportView in supportViews {

            supportView.snp.makeConstraints { make in
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(padding)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(padding)
            }
        }

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(210)
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
            make.height.equalTo(50)
        }
    }

    private func getUserInfo(for username: String) {
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let newUser):
                DispatchQueue.main.async { self.configureUIElements(with: newUser) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func configureUIElements(with user: User) {
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Created at \(user.createdAt.convertToMonthYearFotmat())"
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

extension UserInfoVC: GFRepoItemVCDelegate {

    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL",
                                       message: "The url attached to this user is invalid.",
                                       buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {

    func didTapGetFollowers(for user: User) {
        delegate?.didRequestFollowers(for: user.login)
    }
}
