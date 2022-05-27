//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.04.2022.
//

import UIKit

final class NetworkManager {

    static let shared = NetworkManager(baseURL: "https://api.github.com/users/")

    let cahce = NSCache<NSString, UIImage>()

    private var baseURL: String

    private init (baseURL: String) {
        self.baseURL = baseURL
    }

    func getFollowers(for username: String, page: Int, complition: @escaping (Result<[Follower], NWError>) -> Void) {

        let path = username + "/followers?per_page=100&page=\(page)"

        guard let url = URL(string: baseURL + path) else {
            complition(.failure(NWError.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request) { data, response, error in

            if let _ = error {
                complition(.failure(NWError.unableToComplite))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complition(.failure(NWError.invalidResponse))
                return
            }

            guard let safeData = data else {
                complition(.failure(NWError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: safeData)
                let data = followers
                complition(.success(data))
            } catch {
                complition(.failure(NWError.invalidData))
            }
        }
        task.resume()
    }
}
