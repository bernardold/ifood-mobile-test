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
import Kingfisher

protocol UserSearchView: CoordinatorHolderView {
    var searchUser: PublishSubject<String> { get }

    func displayFoundUser(twitterUser: UserSearchViewModel.User)
    func startLoading()
    func stopLoading()
}

class UserSearchViewController: UIViewController {
    weak var coordinator: Coordinator?
    var presenter: UserSearchPresenter!
    let disposeBag = DisposeBag()

    var searchUser = PublishSubject<String>()
    var resultSelected = PublishSubject<UserSearchViewModel.User?>()

    var searchResult: UserSearchViewModel.User?
    var resultGestureRecognizer: UITapGestureRecognizer!

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var resultView: UIView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var verifyView: UIView!
    @IBOutlet var handleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObservables()
    }
}

extension UserSearchViewController {
    fileprivate func setupView() {
        usernameTextField.delegate = self
        loadingView.isHidden = true
        resultView.isHidden = true

        resultView.layer.borderColor = UIColor.primary.cgColor
        resultView.layer.borderWidth = 2.0
        resultView.layer.cornerRadius = 8.0
        userImageView.layer.cornerRadius = 6.0
        resultGestureRecognizer = UITapGestureRecognizer()
        resultView.addGestureRecognizer(resultGestureRecognizer)
    }

    fileprivate func setupObservables() {
        searchButton.rx.tap.asObservable()
            .map { [weak self] _ in return (self?.usernameTextField.text ?? "") }
            .bind(to: searchUser)
            .disposed(by: disposeBag)

        resultGestureRecognizer.rx.event.asObservable()
            .do(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self?.resultView.backgroundColor = .ligher
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.resultView.backgroundColor = .white
                    })
                })
            })
            .map { [weak self] _ in return self?.searchResult }
            .bind(to: resultSelected)
            .disposed(by: disposeBag)
    }
}

extension UserSearchViewController: UserSearchView {
    func displayFoundUser(twitterUser: UserSearchViewModel.User) {
        searchResult = twitterUser
        userImageView.kf.setImage(with: twitterUser.profileImage)
        nameLabel.text = twitterUser.name
        handleLabel.text = twitterUser.handle
        verifyView.isHidden = !twitterUser.isVerified
        resultView.isHidden = false
    }

    func startLoading() {
        usernameTextField.isEnabled = false
        searchButton.isHidden = true
        loadingView.isHidden = false
        resultView.isHidden = true
    }

    func stopLoading() {
        usernameTextField.isEnabled = true
        searchButton.isHidden = false
        loadingView.isHidden = true
    }
}

extension UserSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchUser.onNext(textField.text ?? "")
        return true
    }
}
