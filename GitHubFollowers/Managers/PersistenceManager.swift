//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 27.06.2022.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard

    private enum Keys {
        static let favorites = "favorites"
    }

    static func updateWith(favorite: Follower, actionType: PersistenceActionType, complition: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        complition(.alreadyInFavorites)
                        return
                    }

                    retrievedFavorites.append(favorite)

                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }

                complition(save(favorites: retrievedFavorites))

            case .failure(let error):
                complition(error)
            }
        }
    }

    static func retrieveFavorites(complition: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            complition(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            complition(.success(favorites))
        } catch {
            complition(.failure(GFError.unableToFavorite))
        }
    }

    static func save(favorites: [Follower]) -> GFError? {

        do {
            let encoder = JSONEncoder()
            let encodedFavotires = try encoder.encode(favorites)
            defaults.set(encodedFavotires, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
