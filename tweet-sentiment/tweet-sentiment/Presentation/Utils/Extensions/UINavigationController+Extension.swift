//
//  UINavigationController+Extension.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setToDefault() {
        view.backgroundColor = .white
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .primary
        navigationBar.tintColor = .white
        let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = titleAttributes
    }
}
