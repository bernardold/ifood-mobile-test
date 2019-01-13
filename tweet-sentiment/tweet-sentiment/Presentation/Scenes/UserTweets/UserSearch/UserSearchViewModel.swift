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
