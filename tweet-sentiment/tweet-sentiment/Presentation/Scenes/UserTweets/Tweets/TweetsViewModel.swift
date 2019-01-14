//
//  TweetsViewModel.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain

struct TweetsViewModel {
    struct Tweet {
        let tweetId: String
        let date: String
        let content: String
        let author: TweetAuthor
    }

    struct TweetAuthor {
        let name: String
        let verified: Bool
        let handle: String
        let profileImage: URL?
    }
}

extension Domain.Tweet {
    func toViewModel() -> TweetsViewModel.Tweet {
        let tweetAuthor = TweetsViewModel.TweetAuthor(name: author.name, verified: author.verified, handle: "@\(author.handle)", profileImage: author.profileImage)
        return TweetsViewModel.Tweet(tweetId: tweetId, date: postDate.dayMonthYear, content: content, author: tweetAuthor)
    }
}

extension Array where Element == Domain.Tweet {
    func toViewModel() -> [TweetsViewModel.Tweet] {
        return map { $0.toViewModel() }
    }
}
