//
//  SentimentAnalysisRemoteModel.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain

struct SentimentAnalysisRemoteModel: Decodable {
    let documentSentiment: SentimentAnalysisRemoteModel.Sentiment
    let language: String
    let sentences: [SentimentAnalysisRemoteModel.Sentence]

    struct Sentiment: Decodable {
        let magnitude: Double
        let score: Double
    }

    struct Sentence: Decodable {
        let sentiment: SentimentAnalysisRemoteModel.Sentiment
        let text: SentimentAnalysisRemoteModel.TextSpan
    }

    struct TextSpan: Decodable {
        let content: String
        let beginOffset: Int
    }
}

extension SentimentAnalysisRemoteModel {
    func toDomainModel() -> Domain.SentimentAnalysis {
        return SentimentAnalysis(language: language, score: documentSentiment.score, magnitude: documentSentiment.magnitude)
    }
}
