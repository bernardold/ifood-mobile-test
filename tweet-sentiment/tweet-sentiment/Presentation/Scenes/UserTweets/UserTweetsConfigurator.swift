//
//  UserTweetsConfigurator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Swinject

func buildUserTweetsContainer(withParent parent: Container, andCoordinator coordinator: Coordinator) -> Container {
    let container = Container(parent: parent)
    container.setupUserSearchScene()
    container.setupTweetsScene()
    container.register(Coordinator.self) { _ in coordinator}
    return container
}
