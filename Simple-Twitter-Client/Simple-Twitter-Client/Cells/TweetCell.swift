//
//  TweetsCell.swift
//  TwitterClientDemo
//
//  Created by Nguyen Nam Long on 10/29/16.
//  Copyright © 2016 Nguyen Nam Long. All rights reserved.
//

import UIKit


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var heightAuto: NSLayoutConstraint!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var replyImage: UIImageView!
    
    
    @IBOutlet weak var retweetActionImage: UIButton!
    
    @IBOutlet weak var favoriteActionImage: UIButton!
    
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    
    var tweetItem: Tweet? {
        didSet {
            
            favoriteCountLabel.text = self.tweetItem?.favoriteCount.description
            retweetCountLabel.text = self.tweetItem?.retweetCount.description
            tweetTextLabel.text = self.tweetItem?.text as String?
            userNameLabel.text = "@\(self.tweetItem!.user!.screenName!)"
            profileLabel.text = self.tweetItem?.user?.name
            
            if let retweet = tweetItem!.retweetBy {
                retweetLabel.text = "\(retweet) Retweeted"
                retweetImage.image = #imageLiteral(resourceName: "retweet-action-on")
                heightAuto.constant = CGFloat(20)
            }else {
                heightAuto.constant = CGFloat(0)
            }
            
            let data = try! Data(contentsOf: tweetItem?.user?.profileImageUrl as! URL)
            profileImage.image = UIImage(data: data)
            
            if (tweetItem?.isFavorited)! {
                favoriteActionImage.isSelected = true
            }else {
                favoriteActionImage.isSelected = false
            }
            
            if(tweetItem?.isRetweeted)! {
                retweetActionImage.isSelected = true
            }else {
                retweetActionImage.isSelected = false
            }
            timeLabel.text = tweetItem?.createdAt
        }
        
    }
    @IBAction func onRetweet(_ sender: UIButton) {
        if retweetActionImage.isSelected {
            retweetActionImage.isSelected = false
            
            
            
        }else {
            retweetActionImage.isSelected = true
            
            
        }
        
    }
    
    @IBAction func onFavorite(_ sender: UIButton) {
        if favoriteActionImage.isSelected {
            favoriteActionImage.isSelected = false
        } else {
            favoriteActionImage.isSelected = true
        }
    }
    
    
    
    
    @IBOutlet weak var onTweet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        retweetActionImage.setImage(#imageLiteral(resourceName: "retweet-action"), for: .normal)
        retweetActionImage.setImage(#imageLiteral(resourceName: "retweet-action-on"), for: .selected)
        favoriteActionImage.setImage(#imageLiteral(resourceName: "like-action-on"), for: .selected)
        favoriteActionImage.setImage(#imageLiteral(resourceName: "like-action"), for: .normal)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
