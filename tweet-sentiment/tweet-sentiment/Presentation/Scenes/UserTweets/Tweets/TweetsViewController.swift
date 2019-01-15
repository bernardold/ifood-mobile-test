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
    func displayTweets(_ tweets: [TweetsViewModel.Tweet], done: Bool)
    func displaySentiment(forTweetId tweetId: String, sentiment: TweetsViewModel.TweetSentiment)
    func displayError(error: TweetsViewModel.Error)
}

class TweetsViewController: UIViewController {
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    var presenter: TweetsPresenter!

    var selectedUser: UserSearchViewModel.User?
    var dataSource = [TweetsViewModel.Tweet]()
    var hasMore: Bool!

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObservables()
        presenter.askForTweets(fromUserHandle: selectedUser?.handle ?? "")
    }
}

extension TweetsViewController {
    fileprivate func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(TweetTableViewCell.nib, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.tableFooterView = makeFooterView()
        hasMore = true
    }

    fileprivate func setupObservables() {
        tableView.rx.itemSelected.asObservable()
            .do(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .filter({  [weak self] indexPath in
                self?.dataSource[indexPath.row].sentiment == nil
            })
            .map({ [weak self] indexPath in
                guard let self = self else { throw NSError() }
                return self.dataSource[indexPath.row]
            })
            .subscribe(onNext: { [weak self] tweet in
                self?.presenter.analyze(tweet: tweet)
            })
            .disposed(by: disposeBag)

        tableView.rx.willDisplayCell.asObservable()
            .filter({ [weak self] (_, indexPath) in
                guard let self = self else { return false }
                return (self.hasMore && indexPath.row == self.dataSource.count - 1)
            })
            .map { [weak self] (_, indexPath) -> String in
                guard let self = self else { return "" }
                return self.dataSource[indexPath.row].tweetId
            }
            .subscribe(onNext: { [weak self] lastTweetId in
                self?.presenter.askForTweets(fromUserHandle: self?.selectedUser?.handle ?? "",
                                            lastTweetId: lastTweetId)
            })
            .disposed(by: disposeBag)
    }

    fileprivate func makeFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.color = .primary
        footer.addSubview(activityIndicator)
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        activityIndicator.center = footer.center
        return footer
    }

    fileprivate func removeLoadingFooter() {
        tableView.tableFooterView = nil
    }
}

extension TweetsViewController: TweetsView {
    func displayTweets(_ tweets: [TweetsViewModel.Tweet], done: Bool) {
        hasMore = !done
        dataSource.append(contentsOf: tweets)
        tableView.reloadData()

        guard done else { return }
        removeLoadingFooter()
    }

    func displaySentiment(forTweetId tweetId: String, sentiment: TweetsViewModel.TweetSentiment) {
        guard let index = dataSource.firstIndex(where: { tweet in return tweet.tweetId == tweetId }) else { return }
        dataSource[index].sentiment = sentiment
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    func displayError(error: TweetsViewModel.Error) {
        let alertController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            guard self.dataSource.isEmpty else { return }
            self.coordinator?.pop()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(withTweet: dataSource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
