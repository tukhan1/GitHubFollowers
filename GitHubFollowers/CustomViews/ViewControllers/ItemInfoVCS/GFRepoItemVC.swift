//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 09.06.2022.
//

import Foundation

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

final class GFRepoItemVC: GFItemInfoVC {

    weak var delegate: GFRepoItemVCDelegate?

    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: ItemInfoType.repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: ItemInfoType.gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }

    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
