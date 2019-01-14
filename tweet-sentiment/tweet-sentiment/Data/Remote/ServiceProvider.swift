//
//  ServiceProvider.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Moya

enum ServiceProvider {
    case getBearerToken
    case searchUsers(handle: String, authorization: String)
    case getTweets(userHandle: String, maxId: String?, authorization: String)

    private var apiCredentials: String { return "9G77kfE3C4aK3u925d8dgvjEy:2LNfH1IIEgdjuRbzPUC4Y8g6ITAAxi7n2RhtMDAOpp5KFeTcxc" }
}

extension ServiceProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .getBearerToken, .searchUsers, .getTweets:
            guard let url = URL(string: "https://api.twitter.com") else {
                fatalError("Error setting Twitter API URL")
            }
            return url
        }
    }

    var path: String {
        switch self {
        case .getBearerToken: return "/oauth2/token"
        case .searchUsers: return "/1.1/users/show.json"
        case .getTweets: return "/1.1/statuses/user_timeline.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBearerToken: return .post
        case .searchUsers, .getTweets: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getBearerToken:
            return .requestParameters(parameters: ["grant_type": "client_credentials"], encoding: URLEncoding.queryString)
        case .searchUsers(let handle, _):
            return .requestParameters(parameters: ["screen_name": handle], encoding: URLEncoding.queryString)
        case .getTweets(let handle, let max, _):
            var parameters: [String: Any] = ["screen_name": handle, "count": 25, "include_rts": 1]
            if let maxId = max {
                parameters["max_id"] = maxId
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getBearerToken:
            let authToken = Data(apiCredentials.utf8).base64EncodedString()
            return ["Authorization": "Basic \(authToken)",
                    "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"]
        case .searchUsers(_, let authorization), .getTweets(_, _, let authorization):
            return ["Authorization": "Bearer \(authorization)",
                    "Content-Type": "application/json"]
        }
    }
}
