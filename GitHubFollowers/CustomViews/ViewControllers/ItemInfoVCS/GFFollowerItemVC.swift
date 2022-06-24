//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 24.06.2022.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        if let user = super.user {
            itemInfoViewOne.set(itemInfoType: ItemInfoType.following, withCount: user.following)
            itemInfoViewTwo.set(itemInfoType: ItemInfoType.followers, withCount: user.followers)
            actionBotton.set(backgroundColor: .systemGreen, title: "Get Followers")
        }
    }
}
