//
//  UserSearchViewController.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit
import RxSwift

protocol UserSearchView: CoordinatorHolderView {

}

class UserSearchViewController: UIViewController {
    weak var coordinator: Coordinator?
    var presenter: UserSearchPresenter!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserSearchViewController: UserSearchView {}
