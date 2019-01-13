//
//  TwitterDataRepository.swift
//  Domain
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

public protocol TwitterDataRepository {
    func getBearerToken() -> Single<BearerToken>
    func searchUser(handle: String) -> Single<TwitterUser>
    func getTweets(handle: String, maxId: String?) -> Single<[Tweet]>
}
