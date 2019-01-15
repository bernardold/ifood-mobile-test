//
//  UserSearchConfigurator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Domain
import Swinject
import SwinjectAutoregistration

extension Container {
    func setupUserSearchScene() {
        register(UserSearchViewController.self) { resolver -> UserSearchViewController in
            UserSearchViewController.instantiate(coordinator: resolver.resolve(Coordinator.self)!)
            }.initCompleted { (resolver, viewController) in
                viewController.presenter = resolver.resolve(UserSearchPresenter.self)!
        }

        register(UserSearchPresenter.self) { resolver -> UserSearchPresenter in
            UserSearchPresenter(view: resolver.resolve(UserSearchViewController.self)!,
                                searchUserUseCase: resolver.resolve(SearchUserUseCase.self)!)
        }
    }
}
