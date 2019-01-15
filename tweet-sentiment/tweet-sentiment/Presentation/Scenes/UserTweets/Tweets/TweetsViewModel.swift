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
        var sentiment: TweetSentiment?
    }

    struct TweetAuthor {
        let name: String
        let verified: Bool
        let handle: String
        let profileImage: URL?
    }

    enum TweetSentiment {
        case happy
        case neutral
        case sad
    }

    struct Error {
        let title: String?
        let message: String?
    }
}

extension TweetsViewModel.TweetSentiment {
    var associatedColor: UIColor {
        switch self {
        case .happy: return .yellow
        case .neutral: return .gray
        case .sad: return .blue
        }
    }

    var description: String {
        switch self {
        case .happy: return "😃"
        case .neutral: return "😐"
        case .sad: return "😔"
        }
    }
}

extension Domain.Tweet {
    func toViewModel() -> TweetsViewModel.Tweet {
        let tweetAuthor = TweetsViewModel.TweetAuthor(name: author.name, verified: author.verified, handle: "@\(author.handle)", profileImage: author.profileImage)
        return TweetsViewModel.Tweet(tweetId: tweetId, date: postDate.dayMonthYear, content: content, author: tweetAuthor, sentiment: nil)
    }
}

extension Array where Element == Domain.Tweet {
    func toViewModel() -> [TweetsViewModel.Tweet] {
        return map { $0.toViewModel() }
    }
}

extension Domain.SentimentAnalysis {
    func toViewModel() -> TweetsViewModel.TweetSentiment {
        switch score {
        case (-1.0)..<(-0.25): return .sad
        case (0.25)...(1.0): return .happy
        default: return .neutral
        }
    }
}

extension DomainError {
    func toTweetsViewModel() -> TweetsViewModel.Error {
        switch self {
        case .notFound:
            return TweetsViewModel.Error(title: "No tweet", message: "This user has no tweets to be analyzed. Please another one.")
        case .notConnectedToInternet:
            return TweetsViewModel.Error(title: "Connection problem", message: "Check your Internet connection and try again.")
        case .authorizationError, .badRequest:
            return TweetsViewModel.Error(title: "Request problem", message: "Something went wrong with your request.")
        case .serverError, .underlying:
            return TweetsViewModel.Error(title: "Ohh, noo..", message: "A problem occured. Please try again later.")
        }
    }
}
