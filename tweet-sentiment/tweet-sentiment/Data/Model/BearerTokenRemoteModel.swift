//
//  BearerToken.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain

struct BearerTokenRemoteModel: Decodable {
    let tokenType: String
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
}

extension BearerTokenRemoteModel {
    func toDomainModel() -> Domain.BearerToken {
        return BearerToken(value: accessToken)
    }
}
