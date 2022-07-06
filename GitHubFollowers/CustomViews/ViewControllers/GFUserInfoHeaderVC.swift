//
//  GHUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 02.06.2022.
//

import UIKit
import SnapKit

final class GFUserInfoHeaderVC: UIViewController {

    private let avatarImageView: GFAvatarImageView = GFAvatarImageView(frame: .zero)
    private let userNameLabel: GFTitleLabel = GFTitleLabel(textAligment: .left, fontSize: 34)
    private let nameLabel: GFSecondaryTitleLabel = GFSecondaryTitleLabel(fontSize: 18)
    private let locationImageView: UIImageView = UIImageView(frame: .zero)
    private let locationLabel: GFSecondaryTitleLabel = GFSecondaryTitleLabel(fontSize: 18)
    private let bioLabel: GFBodyLabel = GFBodyLabel(textAligment: .left)

    private var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUIElements()
        makeConstraints()
    }

    private func configure() {
        view.addSubviews(avatarImageView, userNameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
    }

    func configureUIElements() {
        avatarImageView.downloadImage(fromUrl: user.avatarUrl)
        userNameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio avalible"

        bioLabel.numberOfLines = 3

        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }

    private func makeConstraints() {

        let textImagePadding: CGFloat = 12

        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.width.height.equalTo(95)
        }
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top)
            make.left.equalTo(avatarImageView.snp.right).offset(textImagePadding)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(38)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView.snp.centerY).offset(8)
            make.height.equalTo(20)
            make.left.equalTo(avatarImageView.snp.right).offset(textImagePadding)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        locationImageView.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(textImagePadding)
            make.bottom.equalTo(avatarImageView.snp.bottom)
            make.width.height.equalTo(20)
        }
        locationLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(locationImageView.snp.right).offset(5)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(avatarImageView.snp.bottom)
        }
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(90)
        }
    }
}
