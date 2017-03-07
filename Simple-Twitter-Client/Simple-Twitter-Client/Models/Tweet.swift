//
//  Tweet.swift
//  Simple-Twitter-Client
//
//  Created by Nguyen Nam Long on 3/6/17.
//  Copyright © 2017 Nguyen Nam Long. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    var id: NSNumber?
    var text: String?
    var createdAt: NSDate?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    
    
    var user: User?
    var replyToStatusId: NSNumber?
    var replyToScreenName: String?
    
    var createdAtString: String?
    
    
    var isRetweeted = false
    var isFavorited = false
    var images = [NSURL]()
    var retweet: Tweet?
    
    
    
    
    init(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? NSNumber!
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        replyToStatusId = dictionary["in_reply_to_status_id"] as? NSNumber!
        replyToScreenName = dictionary["in_reply_to_screen_name"] as? String!
        
        text = dictionary["text"] as? String!
        createdAtString = dictionary["created_at"] as? String!
        
        var formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.date(from: createdAtString!) as NSDate?
        
        retweetCount = dictionary["retweet_count"] as? Int ?? 0
        favoriteCount = dictionary["favorite_count"] as? Int ?? 0
        
        isRetweeted = (dictionary["retweeted"] as? Bool!)!
        isFavorited = (dictionary["favorited"] as? Bool!)!
        
        var url = ""
        if let media = dictionary.value(forKeyPath: "extended_entities.media") as? [NSDictionary] {
            for image in media {
                if let urlString = image["media_url"] as? String {
                    images.append(NSURL(string: urlString)!)
                }
                url = (image["url"] as? String)!
            }
        }
        
        // Remove url at the end of text (in case this tweet has images)
//        if !url.isEmpty {
//            text = text?.replace(url, withString: "")
//            text = text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
//        }
//        
        if let retweetDictionary = dictionary["retweeted_status"] as? NSDictionary {
            retweet = Tweet(dictionary: retweetDictionary)
        }
        
    }
    
    class func tweetWithArray(data: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for item in data {
            tweets.append(Tweet(dictionary: item))
        }
        return tweets
    }
}
