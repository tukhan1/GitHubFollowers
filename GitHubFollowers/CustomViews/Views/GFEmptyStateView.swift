//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 28.05.2022.
//

import UIKit
import SnapKit

final class GFEmptyStateView: UIView {

    private let messageLabel: GFTitleLabel = GFTitleLabel(textAligment: .center, fontSize: 28)
    private let logoImageView: UIImageView = UIImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
        configure()
        makeConstraints()
    }

    private func configure() {
        addSubviews(messageLabel, logoImageView)

        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

        logoImageView.image = Images.emptyStateLogo
        logoImageView.alpha = 0.5
    }

    private func makeConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
            make.left.equalTo(self.snp.left).offset(40)
            make.right.equalTo(self.snp.right).inset(40)
            make.height.equalTo(200)
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(self.snp.width).multipliedBy(1.3)
            make.right.equalTo(self.snp.right).offset(150)
            make.bottom.equalTo(self.snp.bottom).offset(100)
        }
    }
}
