//
//  twitterClient.swift
//  Simple-Twitter-Client
//
//  Created by Nguyen Nam Long on 3/4/17.
//  Copyright © 2017 Nguyen Nam Long. All rights reserved.
//

import Foundation
import BDBOAuth1Manager




class TwitterClient: BDBOAuth1SessionManager {
    
    let endPoint = "https://api.twitter.com"
    let API_REQUEST_TOKEN = "/oauth/request_token"
    let API_AUTHENTICATE_TOKEN = "/oauth/authenticate?oauth_token="
    let API_ACCESS_TOKEN = "/oauth/access_token"
    let API_GET_CURRENT_ACCOUNT = "1.1/account/verify_credentials.json"
    let API_GET_STATUS_HOME_TIMELINE = "1.1/statuses/home_timeline.json"
    
    
    var currentUser: User?
    var loginCompletion: ((_ user: User?, _ error: NSError?) -> ())?
    
    

    
    static let shared = TwitterClient(baseURL: URL(string: "https://api.twitter.com"),
                                      consumerKey: "gTPRGiXBqqhFW9xJqfm1NXtKE",
                                      consumerSecret: "lU00jv82tBHDHjZY9BX3NhGgAROjVzzykZde6OXT8n7iiSqshv")
    
    
    func loginSuccess(completion: @escaping (_ user: User?, _ error: NSError?) -> ()) {
        loginCompletion = completion
        TwitterClient.shared?.deauthorize()
        
        TwitterClient.shared?.fetchRequestToken(withPath: API_REQUEST_TOKEN, method: "GET", callbackURL: URL(string: "simpleTwitter://"), scope: nil, success: { (request: BDBOAuth1Credential?) in
            
            let authURL = URL(string: "\(self.endPoint)\(self.API_AUTHENTICATE_TOKEN)\(request!.token!)")!
            UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
            print("Got the request token\n")
            
            
                                                    
        },failure: { (error: Error?) in
            print(">>> Error getting the request token: \(error?.localizedDescription)\n")
            completion(nil, error as! NSError)
            
        })
    }
    
    func getCurrentUser() {
        TwitterClient.shared?.get(API_GET_CURRENT_ACCOUNT, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            TwitterClient.shared?.currentUser = User(dictionary: response as! NSDictionary)
            print(">>>>>DEBUG user \n \(response)")
            self.loginCompletion!(TwitterClient.shared?.currentUser, nil)
        }, failure: { (task: URLSessionDataTask?, error: Error?) in
            print("error getting current user")
            self.loginCompletion!(nil, error as NSError?)
            
        })
    }
    
    func logOut() {
        TwitterClient.shared?.currentUser = nil
        deauthorize()
    }
    
    
    func getHomeTimeline(completion: @escaping ([Tweet]?, Error?) -> ()) {
        TwitterClient.shared?.get(API_GET_STATUS_HOME_TIMELINE, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let tweets = Tweet.tweetWithArray(data: response as! [NSDictionary])
            completion(tweets, nil)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("error getting home timeline")
            completion(nil, error)
        })
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterClient.shared?.fetchAccessToken(withPath: API_ACCESS_TOKEN, method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            print("Got the access token !!!")
            TwitterClient.shared?.requestSerializer.saveAccessToken(accessToken)
            self.getCurrentUser()
            
            
        }, failure: { (error: Error?) in
            print(">>> Error: \(error?.localizedDescription)")
            self.loginCompletion!(nil, error as NSError?)
        })
        
    }
    
    
}
