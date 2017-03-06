//
//  User.swift
//  Simple-Twitter-Client
//
//  Created by Nguyen Nam Long on 3/6/17.
//  Copyright © 2017 Nguyen Nam Long. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let imageURLString = dictionary["profile_image_url"] as? String
        if let imageURLString = imageURLString {
            profileImageUrl = NSURL(string: imageURLString)
        }
        tagline = dictionary["description"] as? String
        
    }
    
    
}
