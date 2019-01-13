//
//  TwitterRemoteDataSource.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class TwitterRemoteDataSource {
    let provider: MoyaProvider<ServiceProvider>

    init(provider: MoyaProvider<ServiceProvider>) {
        self.provider = provider
    }

    func getBearerToken() -> Single<BearerTokenRemoteModel> {
        return provider.rx.request(.getBearerToken)
            .mapError()
            .map(BearerTokenRemoteModel.self)
    }

    func searchUser(handle: String, authorization: String) -> Single<TwitterUserRemoteModel> {
        return provider.rx.request(.searchUsers(handle: handle, authorization: authorization))
            .mapError()
            .map(TwitterUserRemoteModel.self)
    }
}
