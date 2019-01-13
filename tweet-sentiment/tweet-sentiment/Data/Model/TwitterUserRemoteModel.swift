//
//  TwitterUserRemoteModel.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain

struct TwitterUserRemoteModel: Decodable {
    let userId: String
    let name: String
    let screenName: String
    let description: String
    let verified: Bool
    let profileImageURL: String
    let bannerImageURL: String?

    enum CodingKeys: String, CodingKey {
        case userId = "id_str"
        case name = "name"
        case screenName = "screen_name"
        case description = "description"
        case verified = "verified"
        case profileImageURL = "profile_image_url_https"
        case bannerImageURL = "profile_banner_url"
    }
}

extension TwitterUserRemoteModel {
    func toDomainModel() -> TwitterUser {
        return TwitterUser(userId: userId,
                           name: name,
                           handle: screenName,
                           description: description,
                           verified: verified,
                           profileImage: URL(string: profileImageURL.replacingOccurrences(of: "_normal", with: "_bigger")),
                           bannerImage: URL(string: bannerImageURL ?? ""))
    }
}
