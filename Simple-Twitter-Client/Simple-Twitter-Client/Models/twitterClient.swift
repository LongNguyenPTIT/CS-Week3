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
    let twitterToken = ""
    let twitterTokenSecret = ""
    
    static let shared = TwitterClient(baseURL: URL(string: "https://api.twitter.com"),
                                      consumerKey: "gTPRGiXBqqhFW9xJqfm1NXtKE",
                                      consumerSecret: "lU00jv82tBHDHjZY9BX3NhGgAROjVzzykZde6OXT8n7iiSqshv")
    
    
    func getAccessToken() {
        TwitterClient.shared?.deauthorize()
        TwitterClient.shared?.fetchRequestToken(withPath: API_REQUEST_TOKEN,
                                                method: "GET",
                                                callbackURL: URL(string: "simpleTwitter://"),
                                                scope: nil,
                                                success: { (request: BDBOAuth1Credential?) in
                                                    let authURL = URL(string: "\(self.endPoint)\(self.API_AUTHENTICATE_TOKEN)\(request!.token!)")!
                                                    UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
                                                    
        },failure: { (error: Error?) in
            print(">>> Error: \(error?.localizedDescription)")
        })
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterClient.shared?.fetchAccessToken(withPath: API_ACCESS_TOKEN,
                                               method: "POST",
                                               requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
                                                print("login success !!!")
        }, failure: { (error: Error?) in
            print(">>> Error: \(error?.localizedDescription)")
        })
        
    }
    
    
}
