//
//  TweetsPresenter.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain
import RxSwift

struct TweetsPresenter {
    weak var view: TweetsView?
    let disposeBag = DisposeBag()
}

extension TweetsPresenter {
    func askForTweets(fromUserHandle handle: String) {

    }
}
