//
//  UserSearchPresenter.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift

struct UserSearchPresenter {
    let disposeBag: DisposeBag = DisposeBag()
    weak var view: UserSearchView?
}
