//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 09.06.2022.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        if let user = super.user {
            itemInfoViewOne.set(itemInfoType: ItemInfoType.repos, withCount: user.publicRepos)
            itemInfoViewTwo.set(itemInfoType: ItemInfoType.gists, withCount: user.publicGists)
            actionBotton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        }
    }
}
