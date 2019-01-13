//
//  Coordinator.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit

class WeakChild {
    private(set) weak var value: Coordinator?
    init(value: Coordinator?) {
        self.value = value
    }
}

protocol Coordinator: class {
    var children: [WeakChild] { get set }
    var navigationController: UINavigationController? { get set }

    func start()
    func navigate(to scene: CoordinatorScenes)
}

extension Coordinator {
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}

enum CoordinatorScenes {
    case userSearch
    case tweets(user: UserSearchViewModel.User?)
}
