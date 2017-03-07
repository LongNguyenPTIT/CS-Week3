//
//  TweetCell.swift
//  Simple-Twitter-Client
//
//  Created by Nguyen Nam Long on 3/7/17.
//  Copyright © 2017 Nguyen Nam Long. All rights reserved.
//


import UIKit
import Alamofire


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var topIcon: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var imagesView: UIView!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var replyCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var topIconHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topIconWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imagesViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imagesViewToSuperConstraint: NSLayoutConstraint!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            retweetCountLabel.text = String(tweet.retweetCount)
            favoriteCountLabel.text = String(tweet.favoriteCount)
            retweetCountLabel.text = String(tweet.retweetCount)
            screenNameLabel.text = tweet.replyToScreenName
            contentLabel.text = tweet.text
            var formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy hh:mm"
            
            createdAtLabel.text = formatter.string(from: tweet.createdAt as! Date)
            
            if let profileImgUrl = tweet.profileImgUrl {
                Alamofire.request(profileImgUrl).response { response in
                    if let data = response.data {
                        self.profileImage.image = UIImage(data: data)
                    } else {
                        print("Data is nil. I don't know what to do :(")
                    }
                }
            }
            
            
            
            
//            let retweetedConstraints = [topIconHeightConstraint, topLabelHeightConstraint]
//            let imagesViewConstraints = [imagesViewHeightConstraint]
            
//            TwitterHelper.sharedInstance.setDetail(tweet, topLabel: topLabel, topIcon: topIcon, nameLabel: nameLabel, screenNameLabel: screenNameLabel, createdAtLabel: createdAtLabel, contentLabel: contentLabel, profileImage: profileImage, retweetCountLabel: retweetCountLabel, favoriteCountLabel: favoriteCountLabel, retweetButton: retweetButton, favoriteButton: favoriteButton, imagesView: imagesView, retweetedConstraints: retweetedConstraints, imagesViewConstraints: imagesViewConstraints, isDetailView: false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.layer.cornerRadius = 8
        profileImage.layer.masksToBounds = true
        
        imagesView.layer.cornerRadius = 8
        imagesView.layer.masksToBounds = true
        
        contentLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 88
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 88
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        topIconHeightConstraint.constant = 12
        topIconWidthConstraint.constant = 12
        topLabelHeightConstraint.constant = 14.5
        imagesViewHeightConstraint.constant = 115
    }
    
    
    // MARK: Action button
    
    @IBAction func onRetweet(sender: UIButton) {
        
        if let selectedTweetCell = sender.superview?.superview as? TweetCell {
            var selectedTweet = selectedTweetCell.tweet
//            TwitterHelper.sharedInstance.handleRetweet(selectedTweet, retweetCountLabel: retweetCountLabel, retweetButton: retweetButton)
        }
    }
    
    @IBAction func onFavorite(sender: UIButton) {
        
        if let selectedTweetCell = sender.superview?.superview as? TweetCell {
            var selectedTweet = selectedTweetCell.tweet
//            TwitterHelper.sharedInstance.handleFavorite(selectedTweet, favoriteCountLabel: favoriteCountLabel, favoriteButton: favoriteButton)
        }
    }
}

