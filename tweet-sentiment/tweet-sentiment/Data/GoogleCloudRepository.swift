//
//  GoogleCloudRepository.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import Moya

struct GoogleCloudRepository: GoogleCloudDataRepository {
    private let googleRemoteDataSource: GoogleCloudRemoteDataSource

    public init(googleRemoteDataSource: GoogleCloudRemoteDataSource) {
        self.googleRemoteDataSource = googleRemoteDataSource
    }

    func analyzeTweet(text: String) -> Single<SentimentAnalysis> {
        return googleRemoteDataSource.analyzeDocument(GoogleDocumentRemoteModel(document: GoogleDocumentRemoteModel.Document(content: text)))
            .map({ $0.toDomainModel() })
    }
}
