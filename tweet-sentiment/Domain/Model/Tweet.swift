//
//  Tweet.swift
//  Domain
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

public struct Tweet {
    public let tweetId: String
    public let postDate: Date
    public let content: String
    public let author: TwitterUser
    public let replyCount: Int
    public let retweetCount: Int
    public let favoriteCount: Int

    public init(tweetId: String, postDate: Date, content: String, author: TwitterUser, replyCount: Int, retweetCount: Int, favoriteCount: Int) {
        self.tweetId = tweetId
        self.postDate = postDate
        self.content = content
        self.author = author
        self.replyCount = replyCount
        self.retweetCount = retweetCount
        self.favoriteCount = favoriteCount
    }
}
