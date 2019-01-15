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
    case analyze(document: GoogleDocumentRemoteModel)

    private var twApiCredentials: String { return "9G77kfE3C4aK3u925d8dgvjEy:2LNfH1IIEgdjuRbzPUC4Y8g6ITAAxi7n2RhtMDAOpp5KFeTcxc" }
    private var gcpApiKey: String { return "AIzaSyBnCgiVE-r0PUmoj2PEqEjVljhEDRnuPcU" }
}

extension ServiceProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .getBearerToken, .searchUsers, .getTweets:
            guard let url = URL(string: "https://api.twitter.com") else {
                fatalError("Error setting Twitter API URL")
            }
            return url
        case .analyze:
            guard let url = URL(string: "https://language.googleapis.com/v1beta2") else {
                fatalError("Error setting Google API URL")
            }
            return url
        }
    }

    var path: String {
        switch self {
        case .getBearerToken: return "/oauth2/token"
        case .searchUsers: return "/1.1/users/show.json"
        case .getTweets: return "/1.1/statuses/user_timeline.json"
        case .analyze: return "/documents:analyzeSentiment"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBearerToken, .analyze: return .post
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
        case .analyze(let document):
            let documentData = try? JSONEncoder().encode(document)
            return .requestCompositeData(bodyData: documentData ?? Data(), urlParameters: ["key": gcpApiKey])
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getBearerToken:
            let authToken = Data(twApiCredentials.utf8).base64EncodedString()
            return ["Authorization": "Basic \(authToken)",
                    "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"]
        case .searchUsers(_, let authorization), .getTweets(_, _, let authorization):
            return ["Authorization": "Bearer \(authorization)",
                    "Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
