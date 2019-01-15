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
    func setup() {
        view?.searchUser
            .flatMap({ username in
                return self.searchUserUseCase.getSingle(request: SearchUserUseCase.Request(handle: username))
                    .map({ $0.toViewModel() })
                    .do(onSuccess: { user in
                        self.view?.stopLoading()
                        self.view?.displayFoundUser(twitterUser: user)
                    }, onError: { error in
                        self.view?.stopLoading()
                        // TODO: handle errors
                        print(error)
                    }, onSubscribe: {
                        self.view?.startLoading()
                    })
                    .asCompletable()
                    .catchError({ _ in Completable.empty() })
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
