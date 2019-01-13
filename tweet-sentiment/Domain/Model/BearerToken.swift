//
//  BearerToken.swift
//  Domain
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

public struct BearerToken {
    public let value: String

    public init(value: String) {
        self.value = value
    }
}
