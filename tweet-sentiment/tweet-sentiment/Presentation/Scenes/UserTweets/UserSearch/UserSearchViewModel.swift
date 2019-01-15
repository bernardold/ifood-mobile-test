//
//  UserSearchViewModel.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain

struct UserSearchViewModel {
    struct User {
        let userId: String
        let name: String
        let handle: String
        let isVerified: Bool
        let profileImage: URL?
    }

    struct Error {
        let title: String?
        let message: String?
    }
}

extension Domain.TwitterUser {
    func toViewModel() -> UserSearchViewModel.User {
        return UserSearchViewModel.User(userId: userId,
                                        name: name,
                                        handle: "@\(handle)",
                                        isVerified: verified,
                                        profileImage: profileImage)
    }
}

extension DomainError {
    func toViewModel() -> UserSearchViewModel.Error {
        switch self {
        case .notFound:
            return UserSearchViewModel.Error(title: "User not found", message: "Try another Twitter username.")
        case .notConnectedToInternet:
            return UserSearchViewModel.Error(title: "Connection problem", message: "Check your Internet connection and try again.")
        case .authorizationError, .badRequest:
            return UserSearchViewModel.Error(title: "Request problem", message: "There's something wrong with your request.")
        case .serverError, .underlying:
            return UserSearchViewModel.Error(title: "Ohh, noo..", message: "A problem occured. Please try again later.")
        }
    }
}
