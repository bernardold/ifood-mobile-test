//
//  UserSearchViewController.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol UserSearchView: CoordinatorHolderView {
    var searchUser: PublishSubject<String> { get }
}

class UserSearchViewController: UIViewController {
    weak var coordinator: Coordinator?
    var presenter: UserSearchPresenter!
    let disposeBag = DisposeBag()

    var searchUser = PublishSubject<String>()

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObservables()
    }
}

extension UserSearchViewController {
    fileprivate func setupView() {
        usernameTextField.delegate = self
    }

    fileprivate func setupObservables() {
        searchButton.rx.tap.asObservable()
            .map { [weak self] _ in return (self?.usernameTextField.text ?? "") }
            .bind(to: searchUser)
            .disposed(by: disposeBag)
    }
}

extension UserSearchViewController: UserSearchView {}

extension UserSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchUser.onNext(textField.text ?? "")
        return true
    }
}
