//
//  AppConfigurator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit
import Moya
import Swinject
import SwinjectAutoregistration

func buildAppContainer() -> Container {
    let container = Container()
    container.setupCoordinators()
    return container
}

extension Container {
    func setupCoordinators() {
        register(UserTweetsCoordinator.self) { (_, navigation) -> UserTweetsCoordinator in
            UserTweetsCoordinator(navigationController: navigation, parentContainer: self)
        }
    }
}
