//
//  User.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.04.2022.
//

struct User: Codable {
    var username: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var html_url: String
    var following: Int
    var followers: Int
    var createdAt: String
}
