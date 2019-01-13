//
//  GetTweetsUseCase.swift
//  Domain
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

public class GetTweetsUseCase: UseCase {
    public let twitterRepository: TwitterDataRepository

    public init(twitterRepository: TwitterDataRepository) {
        self.twitterRepository = twitterRepository
    }

    public func getSingle(request: GetTweetsUseCase.Request) -> Single<[Tweet]> {
        // `max_id` parameter to paginate the service
        var maxId: String?
        if let oldestIdStr = request.oldestTweetId {
            let oldestId = Int64(oldestIdStr) ?? 0
            maxId = "\(oldestId - 1)"
        }
        return twitterRepository.getTweets(handle: request.handle, maxId: maxId)
    }

    public struct Request {
        public let handle: String
        public let oldestTweetId: String?
        public init(handle: String, oldestTweetId: String?) {
            self.handle = handle
            self.oldestTweetId = oldestTweetId
        }
    }
}
