//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 24.06.2022.
//

import Foundation

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

final class GFFollowerItemVC: GFItemInfoVC {

    weak var delegate: GFFollowerItemVCDelegate?

    init(user: User, delegate: GFFollowerItemVCDelegate) {
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
