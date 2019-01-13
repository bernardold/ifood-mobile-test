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

    let getTweetsUseCase: GetTweetsUseCase
}

extension TweetsPresenter {
    func askForTweets(fromUserHandle handle: String, lastTweetId: String? = nil) {
        let request = GetTweetsUseCase.Request(handle: handle, oldestTweetId: lastTweetId)
        getTweetsUseCase.getSingle(request: request)
            .subscribe(onSuccess: { tweets in
                print(tweets)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
