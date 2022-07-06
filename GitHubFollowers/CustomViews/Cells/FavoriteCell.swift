//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 28.06.2022.
//

import UIKit
import SnapKit

final class FavoriteCell: UITableViewCell {

    static let identifier = "\(FavoriteCell.self)"

    private let avatarImageView: GFAvatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel: GFTitleLabel = GFTitleLabel(textAligment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(favorite: Follower) {
        avatarImageView.downloadImage(fromUrl: favorite.avatarUrl)
        self.usernameLabel.text = favorite.login
    }

    private func configure() {
        addSubviews(avatarImageView, usernameLabel)

        accessoryType = .disclosureIndicator
    }

    private func makeConstraints() {
        let padding: CGFloat = 12

        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(padding)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(60)
        }
        usernameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(padding)
            make.right.equalTo(self.snp.right).offset(padding)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(40)
        }
    }
}
