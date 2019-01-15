//
//  TweetsConfigurator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain
import Swinject
import SwinjectAutoregistration

extension Container {
    func setupTweetsScene() {
        register(TweetsViewController.self) { resolver -> TweetsViewController in
            TweetsViewController.instantiate(coordinator: resolver.resolve(Coordinator.self)!)
            }.initCompleted { (resolver, viewController) in
                viewController.presenter = resolver.resolve(TweetsPresenter.self)!
        }

        register(TweetsPresenter.self) { resolver -> TweetsPresenter in
            TweetsPresenter(view: resolver.resolve(TweetsViewController.self)!,
                            getTweetsUseCase: resolver.resolve(GetTweetsUseCase.self)!,
                            analyzeTweetUseCase: resolver.resolve(AnalyzeTweetSentimentUseCase.self)!)
        }
    }
}
