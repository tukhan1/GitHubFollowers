//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 05.04.2022.
//

import UIKit
import SnapKit

final class FollowerCell: UICollectionViewCell {

    static var identifier = "\(FollowerCell.self)"

    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAligment: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follower: Follower) {
        avatarImageView.downloadImage(fromUrl: follower.avatarUrl)
        usernameLabel.text = follower.login
    }

    private func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
    }

    private func makeContraints() {
        let padding: CGFloat = 10
        avatarImageView.snp.makeConstraints { maker in
            maker.top.equalTo(contentView.snp.top).offset(padding)
            maker.centerX.equalTo(contentView.snp.centerX)
            maker.height.width.equalTo(contentView.snp.width).multipliedBy(0.9)
        }
        usernameLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(contentView.snp.bottom).inset(padding)
            maker.centerX.equalTo(contentView.snp.centerX)
            maker.width.equalTo(avatarImageView.snp.width)
        }
    }
}
