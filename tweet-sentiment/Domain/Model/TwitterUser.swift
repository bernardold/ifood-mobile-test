//
//  TwitterUser.swift
//  Domain
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

public struct TwitterUser {
    public let userId: String
    public let name: String
    public let handle: String
    public let description: String
    public let verified: Bool
    public let profileImage: URL?
    public let bannerImage: URL?

    public init(userId: String, name: String, handle: String, description: String, verified: Bool, profileImage: URL?, bannerImage: URL?) {
        self.userId = userId
        self.name = name
        self.handle = handle
        self.description = description
        self.verified = verified
        self.profileImage = profileImage
        self.bannerImage = bannerImage
    }
}
