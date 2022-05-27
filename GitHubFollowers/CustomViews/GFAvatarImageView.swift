//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 05.04.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let cache = NetworkManager.shared.cahce
    private let placeholderImage = UIImage(named: "empty-state-logo")!
    
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
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let safeData = data else { return }

            guard let image = UIImage(data: safeData) else { return }
            DispatchQueue.main.async {
                self.cache.setObject(image, forKey: cacheKey)
                self.image = image
            }
        }
        task.resume()
    }
}
