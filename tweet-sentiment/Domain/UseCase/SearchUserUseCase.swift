//
//  SearchUserUseCase.swift
//  Domain
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

public class SearchUserUseCase: UseCase {
    public let twitterRepository: TwitterDataRepository

    public init(twitterRepository: TwitterDataRepository) {
        self.twitterRepository = twitterRepository
    }

    public func getSingle(request: SearchUserUseCase.Request) -> Single<TwitterUser> {
        return twitterRepository.searchUser(handle: request.handle)
    }

    public struct Request {
        public let handle: String
        public init(handle: String) {
            self.handle = handle
        }
    }
}
