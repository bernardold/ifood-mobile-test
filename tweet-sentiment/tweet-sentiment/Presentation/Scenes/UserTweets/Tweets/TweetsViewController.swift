//
//  TweetsViewController.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit
import RxSwift

protocol TweetsView: CoordinatorHolderView {
    func displayTweets()
}

class TweetsViewController: UIViewController {
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    var presenter: TweetsPresenter!

    var selectedUser: UserSearchViewModel.User?
    var dataSource = [TweetsViewModel.Tweets]()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.askForTweets(fromUserHandle: selectedUser?.handle ?? "")
    }
}

extension TweetsViewController {
    fileprivate func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    fileprivate func setupObservables() {

    }
}

extension TweetsViewController: TweetsView {
    func displayTweets() {
    }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
}
