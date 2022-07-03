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

    func getFollowers(for username: String, page: Int, complition: @escaping (Result<[Follower], GFError>) -> Void) {

        let path = username + "/followers?per_page=100&page=\(page)"

        guard let url = URL(string: baseURL + path) else {
            complition(.failure(GFError.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request) { data, response, error in

            if let _ = error {
                complition(.failure(GFError.unableToComplite))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complition(.failure(GFError.invalidResponse))
                return
            }

            guard let safeData = data else {
                complition(.failure(GFError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: safeData)
                let data = followers
                complition(.success(data))
            } catch {
                complition(.failure(GFError.invalidData))
            }
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, complition: @escaping (Result<User, GFError>) -> Void ){
        guard let url = URL(string: baseURL + username) else {
            complition(.failure(GFError.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request) { data, response, error in

            if let _ = error {
                complition(.failure(GFError.unableToComplite))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complition(.failure(GFError.invalidResponse))
                return
            }

            guard let safeData = data else {
                complition(.failure(GFError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: safeData)
                complition(.success(user))
            } catch {
                complition(.failure(GFError.invalidData))
            }
        }
        task.resume()
    }
}
