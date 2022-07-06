//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 05.04.2022.
//

import UIKit

final class GFAvatarImageView: UIImageView {

    private let placeholderImage = Images.placeholder

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }

    func downloadImage(fromUrl url: String) {

        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
