//
//  UserTweetsCoordinator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Swinject

class UserTweetsCoordinator: Coordinator {
    var children = [WeakChild]()
    var parentContainer: Container
    weak var navigationController: UINavigationController?
    lazy var container: Container = {
        return buildUserTweetsContainer(withParent: parentContainer, andCoordinator: self)
    }()

    init(navigationController: UINavigationController, parentContainer: Container) {
        self.navigationController = navigationController
        self.parentContainer = parentContainer
    }

    func start() {
        let viewController = container.resolve(UserSearchViewController.self)!
        viewController.navigationItem.title = "Find Twitter User"
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.setToDefault()
    }
}

extension UserTweetsCoordinator {
    func navigate(to scene: CoordinatorScenes) {

    }
}
