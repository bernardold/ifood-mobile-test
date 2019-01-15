//
//  PrimitiveSequence+Moya.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain
import Moya
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapError() -> Single<Response> {
        return catchError({ error in
            guard let moyaError = error as? MoyaError else {
                return Single.error(DomainError.underlying)
            }
            switch moyaError {
            case .underlying(let nsError as NSError, _):
                var domainError: DomainError
                switch nsError.code {
                case NSURLErrorNotConnectedToInternet, NSURLErrorTimedOut:
                    domainError = .notConnectedToInternet
                default: domainError = .underlying
                }
                return Single.error(domainError)

            default: return Single.error(DomainError.underlying)
            }
        })
        .flatMap { response in
            do {
                let successfulResponse = try response.filterSuccessfulStatusCodes()
                return Single.just(successfulResponse)
            } catch {
                // https://cloud.google.com/storage/docs/json_api/v1/status-codes
                // https://developer.twitter.com/en/docs/basics/response-codes
                switch response.statusCode {
                case 400, 406:
                    return Single.error(DomainError.badRequest)
                case 401, 403:
                    return Single.error(DomainError.authorizationError)
                case 404:
                    return Single.error(DomainError.notFound)
                case 500 ... 504:
                    return Single.error(DomainError.serverError)
                default:
                    return Single.error(DomainError.underlying)
                }
            }
        }
    }
}
