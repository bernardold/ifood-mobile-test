//
//  NibLoadable.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit

protocol NibLoadable {}

extension UIViewController: NibLoadable {}
extension UIView: NibLoadable {}

extension NibLoadable where Self: UIViewController {
    static func instantiate() -> Self {
        return Self(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibLoadable where Self: CoordinatorHolderView, Self: UIViewController {
    static func instantiate(coordinator: Coordinator) -> Self {
        let viewController = Self(nibName: String(describing: self), bundle: Bundle(for: self))
        viewController.coordinator = coordinator
        return viewController
    }
}

extension NibLoadable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    func loadNibContent() {
        for view in Self.nib.instantiate(withOwner: self, options: nil) {
            if let view = view as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
                let constraintAttributes: [NSLayoutConstraint.Attribute] = [.leading, .top, .trailing, .bottom]
                constraintAttributes.forEach { attribute in
                    self.addConstraint(NSLayoutConstraint(item: view,
                                                          attribute: attribute,
                                                          relatedBy: .equal,
                                                          toItem: self,
                                                          attribute: attribute,
                                                          multiplier: 1,
                                                          constant: 0.0))
                }
            }
        }
    }
}
