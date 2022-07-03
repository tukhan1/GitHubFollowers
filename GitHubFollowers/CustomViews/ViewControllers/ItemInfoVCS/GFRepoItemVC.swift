//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 09.06.2022.
//

import Foundation

final class GFRepoItemVC: GFItemInfoVC {
    
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
