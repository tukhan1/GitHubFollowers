//
//  User.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.04.2022.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let url: String
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
