//
//  UserSearchPresenter.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 12/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation
import RxSwift
import Domain

struct UserSearchPresenter {
    let disposeBag: DisposeBag = DisposeBag()
    weak var view: UserSearchView?

    let searchUserUseCase: Domain.SearchUserUseCase
}

extension UserSearchPresenter {
    func askForTwitterUser(withHandle handle: String) {
        return self.searchUserUseCase.getSingle(request: SearchUserUseCase.Request(handle: handle))
            .map({ $0.toViewModel() })
            .do(onSuccess: { user in
                self.view?.stopLoading()
                self.view?.displayFoundUser(twitterUser: user)
            }, onError: { error in
                self.view?.stopLoading()
                guard let domainError = error as? DomainError else { return }
                self.view?.displayError(error: domainError.toViewModel())
            }, onSubscribe: {
                self.view?.startLoading()
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
