//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 08.06.2022.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    private let itemImageView: UIImageView = UIImageView(frame: .zero)
    private let itemTitleLabel: GFTitleLabel = GFTitleLabel(textAligment: .left, fontSize: 16)
    private let itemCounter: GFTitleLabel = GFTitleLabel(textAligment: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(itemImageView)
        addSubview(itemTitleLabel)
        addSubview(itemCounter)
        
        itemImageView.tintColor = .label
    }

    private func makeConstraints() {
        let padding = 10
        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(padding)
            make.left.equalTo(self.snp.left).offset(padding)
            make.height.width.equalTo(20)
        }
        itemTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.top)
            make.left.equalTo(itemImageView.snp.right).offset(padding)
            make.right.equalTo(self.snp.right).inset(padding)
            make.height.equalTo(20)
        }
        itemCounter.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(padding)
            make.left.equalTo(self.snp.left).offset(padding)
            make.right.equalTo(self.snp.right).offset(padding)
            make.bottom.equalTo(self.snp.bottom).offset(padding)
        }
    }

    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            itemImageView.image = UIImage(systemName: SFSymbols.repos)
            itemTitleLabel.text = "Public Repos"
        case .gists:
            itemImageView.image = UIImage(systemName: SFSymbols.gists)
            itemTitleLabel.text = "Public Gists"
        case .followers:
            itemImageView.image = UIImage(systemName: SFSymbols.followers)
            itemTitleLabel.text = "Followers"
        case .following:
            itemImageView.image = UIImage(systemName: SFSymbols.following)
            itemTitleLabel.text = "Following"
        }
        itemCounter.text = String(count)
    }
}
