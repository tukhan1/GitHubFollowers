//
//  NWError.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 01.04.2022.
//

enum GFError: String, Error {
    case invalidUrl = "The username is incorrect. Let's try again with new name."
    case invalidData = "There is some problem with followers. Try again a bit later."
    case invalidResponse = "Invalid response from the server. Try again later."
    case unableToComplite = "Unable to complite this action. Check your internet connection and try again 😉"
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user."
}
