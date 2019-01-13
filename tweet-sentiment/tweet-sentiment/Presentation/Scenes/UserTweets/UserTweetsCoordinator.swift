//
//  UserTweetsCoordinator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

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
        viewController.navigationItem.title = "Tweet's Sentiment"
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.setToDefault()

        viewController.resultSelected
            .subscribe(onNext: { [weak self] user in
                self?.navigate(to: .tweets(user: user))
            })
            .disposed(by: viewController.disposeBag)
    }
}

extension UserTweetsCoordinator {
    func navigate(to scene: CoordinatorScenes) {
        switch scene {
        case .userSearch:
            navigationController?.popToRootViewController(animated: true)
        case .tweets(let user):
            navigateToTweetList(user: user)
        }
    }

    private func navigateToTweetList(user: UserSearchViewModel.User?) {
        let viewController = self.container.resolve(TweetsViewController.self)!
        viewController.selectedUser = user
        viewController.navigationItem.title = user?.handle ?? ""
        navigationController?.pushViewController(viewController, animated: true)
    }
}
