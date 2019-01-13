//
//  UseCase.swift
//  Domain
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

public protocol UseCase {
    associatedtype RequestModel
    associatedtype ResponseModel
    func getSingle(request: RequestModel) -> Single<ResponseModel>
}
