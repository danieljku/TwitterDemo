//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var username: NSString?
    var timestamp: String?
    var retweetCount: Int?
    var favoritesCount: Int?
    var profilePhotoUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        let user = dictionary["user"] as! NSDictionary
        favoritesCount = (user["favourites_count"] as? Int) ?? 0
        username = user["name"] as? NSString
        
        let profileUrlString = user["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profilePhotoUrl = NSURL(string: profileUrlString)
        }
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            let date = formatter.date(from: timeStampString)
            formatter.dateFormat = "MM/dd/yy"
            timestamp = formatter.string(from: date!)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
        
    }
}
