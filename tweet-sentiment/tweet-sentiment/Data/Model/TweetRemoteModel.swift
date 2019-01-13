//
//  TweetRemoteModel.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain

struct TweetRemoteModel: Decodable {
    let tweetId: String
    let createdAt: String
    let text: String
    let user: TwitterUserRemoteModel
    let replyCount: Int?
    let retweetCount: Int?
    let favoriteCount: Int?

    enum CodingKeys: String, CodingKey {
        case tweetId = "id_str"
        case createdAt = "created_at"
        case text = "text"
        case user = "user"
        case replyCount = "reply_count"
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
    }
}

extension TweetRemoteModel {
    func toDomainModel() -> Domain.Tweet {
        return Tweet(tweetId: tweetId,
                     postDate: createdAt.toDate(usingFormatter: DateFormatter.twitterTimestampFormat) ?? Date(),
                     content: text,
                     author: user.toDomainModel(),
                     replyCount: replyCount ?? 0,
                     retweetCount: retweetCount ?? 0,
                     favoriteCount: favoriteCount ?? 0)
    }
}

extension Array where Element == TweetRemoteModel {
    func toDomainModel() -> [Domain.Tweet] {
        return map { $0.toDomainModel() }
    }
}
