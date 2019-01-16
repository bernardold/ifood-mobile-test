//
//  TweetTableViewCell.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 13/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import UIKit
import Kingfisher

class TweetTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var verifiedView: UIView!
    @IBOutlet var handleLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var sentimentView: UIView!
    @IBOutlet var sentimentLabel: UILabel!

    func configure(withTweet tweet: TweetsViewModel.Tweet) {
        profileImageView.kf.setImage(with: tweet.author.profileImage)
        nameLabel.text = tweet.author.name
        verifiedView.isHidden = !tweet.author.verified
        handleLabel.text = tweet.author.handle
        tweetLabel.text = tweet.content
        dateLabel.text = tweet.date
        sentimentView.isHidden = true
        profileImageView.layer.cornerRadius = (profileImageView.frame.width / 2.0)

        guard let sentiment = tweet.sentiment else { return }
        sentimentView.isHidden = false
        sentimentView.layer.cornerRadius = 14.0
        sentimentView.backgroundColor = sentiment.associatedColor
        sentimentLabel.text = sentiment.description
    }
}
