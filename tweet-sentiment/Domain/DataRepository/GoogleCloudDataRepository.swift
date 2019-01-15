//
//  GoogleCloudDataRepository.swift
//  Domain
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

public protocol GoogleCloudDataRepository {
    func analyzeTweet(text: String) -> Single<SentimentAnalysis>
}
