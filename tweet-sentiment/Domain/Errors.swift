//
//  Errors.swift
//  Domain
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

public enum DomainError: Error {
    case underlying
    case notConnectedToInternet
    // TODO: add APIs errors
}
