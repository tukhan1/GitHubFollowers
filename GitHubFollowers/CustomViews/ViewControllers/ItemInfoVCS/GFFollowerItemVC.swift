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
        itemInfoViewOne.set(itemInfoType: ItemInfoType.following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: ItemInfoType.followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers",
                                       message: "This user has no followers.",
                                       buttonTitle: "So sad")
            return
        }
        delegate?.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
