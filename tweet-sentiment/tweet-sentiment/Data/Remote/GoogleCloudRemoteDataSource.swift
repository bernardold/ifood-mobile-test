//
//  GoogleCloudRemoteDataSource.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class GoogleCloudRemoteDataSource {
    let provider: MoyaProvider<ServiceProvider>

    init(provider: MoyaProvider<ServiceProvider>) {
        self.provider = provider
    }

    func analyzeDocument(_ document: GoogleDocumentRemoteModel) -> Single<SentimentAnalysisRemoteModel> {
        return provider.rx.request(.analyze(document: document))
            .mapError()
            .map(SentimentAnalysisRemoteModel.self)
    }
}
