//
//  Followers.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.04.2022.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}
