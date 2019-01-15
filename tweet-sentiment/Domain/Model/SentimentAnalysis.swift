//
//  SentimentAnalysis.swift
//  Domain
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

public struct SentimentAnalysis {
    public let language: String
    public let score: Double
    public let magnitude: Double

    public init(language: String, score: Double, magnitude: Double) {
        self.language = language
        self.score = score
        self.magnitude = magnitude
    }
}
