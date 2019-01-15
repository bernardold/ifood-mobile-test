//
//  AnalyzeTweetSentimentUseCase.swift
//  Domain
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

public class AnalyzeTweetSentimentUseCase: UseCase {
    public let googleCloudRepository: GoogleCloudDataRepository

    public init(googleCloudRepository: GoogleCloudDataRepository) {
        self.googleCloudRepository = googleCloudRepository
    }

    public func getSingle(request: AnalyzeTweetSentimentUseCase.Request) -> Single<SentimentAnalysis> {
        return googleCloudRepository.analyzeTweet(text: request.tweetText)
    }

    public struct Request {
        public let tweetText: String
        public init(tweetText: String) {
            self.tweetText = tweetText
        }
    }
}
