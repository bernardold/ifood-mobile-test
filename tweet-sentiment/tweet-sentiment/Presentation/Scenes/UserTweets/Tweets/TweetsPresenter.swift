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
    let analyzeTweetUseCase: AnalyzeTweetSentimentUseCase
}

extension TweetsPresenter {
    func askForTweets(fromUserHandle handle: String, lastTweetId: String? = nil) {
        let request = GetTweetsUseCase.Request(handle: handle, oldestTweetId: lastTweetId)
        getTweetsUseCase.getSingle(request: request)
            .map({ $0.toViewModel() })
            .subscribe(onSuccess: { tweets in
                self.view?.displayTweets(tweets, done: (tweets.count < 25))
            }, onError: { error in
                // TODO: handle Errors
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func analyze(tweet: TweetsViewModel.Tweet) {
        let request = AnalyzeTweetSentimentUseCase.Request(tweetText: tweet.content)
        analyzeTweetUseCase.getSingle(request: request)
            .map({ $0.toViewModel() })
            .subscribe(onSuccess: { sentiment in
                self.view?.displaySentiment(forTweetId: tweet.tweetId, sentiment: sentiment)
            }, onError: { error in
                // TODO: handle Errors
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
