//
//  AppConfigurator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit
import Domain
import Moya
import Swinject
import SwinjectAutoregistration

func buildAppContainer() -> Container {
    let container = Container()
    container.setupCoordinators()
    container.setupNetwork()
    container.setupDomain()
    return container
}

extension Container {
    func setupCoordinators() {
        register(UserTweetsCoordinator.self) { (_, navigation) -> UserTweetsCoordinator in
            UserTweetsCoordinator(navigationController: navigation, parentContainer: self)
        }
    }

    func setupNetwork() {
        register(MoyaProvider<ServiceProvider>.self, factory: {_ in
            MoyaProvider<ServiceProvider>(plugins: [NetworkLoggerPlugin(verbose: true)])
        })
        // Twitter API
        autoregister(TwitterRepository.self, initializer: TwitterRepository.init)
        autoregister(TwitterRemoteDataSource.self, initializer: TwitterRemoteDataSource.init)
        // Google API
        autoregister(GoogleCloudRepository.self, initializer: GoogleCloudRepository.init)
        autoregister(GoogleCloudRemoteDataSource.self, initializer: GoogleCloudRemoteDataSource.init)
    }

    func setupDomain() {
        autoregister(TwitterDataRepository.self, initializer: TwitterRepository.init)
        autoregister(GoogleCloudDataRepository.self, initializer: GoogleCloudRepository.init)
        // Use Cases
        autoregister(SearchUserUseCase.self, initializer: SearchUserUseCase.init)
        autoregister(GetTweetsUseCase.self, initializer: GetTweetsUseCase.init)
        autoregister(AnalyzeTweetSentimentUseCase.self, initializer: AnalyzeTweetSentimentUseCase.init)

    }
}
