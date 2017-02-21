//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var username: String?
    var screenName: String?
    var timestamp: String?
    var retweetCount: Int?
    var favoritesCount: Int?
    var profilePhotoUrl: URL?
    //var replyCount: Int?
    var tweetID: String?
    var didRetweet: Bool?
    var didFavorite: Bool?
    var retweetedUsername: String?

    
    init(dictionary: NSDictionary) {
        if let retweetedPost = dictionary["retweeted_status"] as? NSDictionary{
            let retweetUser = dictionary["user"] as! NSDictionary
            retweetedUsername = retweetUser["name"] as? String
            let user = retweetedPost["user"] as! NSDictionary
            text = retweetedPost["text"] as? String
            retweetCount = (retweetedPost["retweet_count"] as? Int) ?? 0
            favoritesCount = (retweetedPost["favorite_count"] as? Int) ?? 0
            username = user["name"] as? String
            screenName = user["screen_name"] as? String
            
            let profileUrlString = user["profile_image_url_https"] as? String
            if let profileUrlString = profileUrlString {
                profilePhotoUrl = URL(string: profileUrlString)
            }
            
            let timeStampString = retweetedPost["created_at"] as? String
            
            if let timeStampString = timeStampString {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                let date = formatter.date(from: timeStampString)
                formatter.dateFormat = "MM/dd/yy"
                timestamp = formatter.string(from: date!)
            }
            
            if let tweetid = retweetedPost["id_str"] as? String{
                tweetID = tweetid
            }
            didRetweet = retweetedPost["retweeted"] as? Bool
            didFavorite = retweetedPost["favorited"] as? Bool
        
        }else{
            text = dictionary["text"] as? String
            retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
            let user = dictionary["user"] as! NSDictionary
            favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
            username = user["name"] as? String
            screenName = user["screen_name"] as? String
            
            let profileUrlString = user["profile_image_url_https"] as? String
            if let profileUrlString = profileUrlString {
                profilePhotoUrl = URL(string: profileUrlString)
            }
            
            let timeStampString = dictionary["created_at"] as? String
            
            if let timeStampString = timeStampString {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                let date = formatter.date(from: timeStampString)
                formatter.dateFormat = "MM/dd/yy"
                timestamp = formatter.string(from: date!)
            }
            
            if let tweetid = dictionary["id_str"] as? String{
                tweetID = tweetid
            }
            didRetweet = dictionary["retweeted"] as? Bool
            didFavorite = dictionary["favorited"] as? Bool
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
    
    func updateFavorite(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.favorite(tweet: self, success: { 
            if self.didFavorite == true{
                self.favoritesCount! -= 1
                self.didFavorite = false
            }else{
                self.favoritesCount! += 1
                self.didFavorite = true
            }
            
            success()
        }, failure: { (error: Error) in
            failure(error)
        })
    }
    
    func updateRetweet(success: @escaping ()->(), failure: @escaping (Error) ->()){
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.retweet(tweet: self, success: {
            if self.didRetweet == true {
                self.retweetCount! -= 1
                self.didRetweet = false
            } else {
                self.retweetCount! += 1
                self.didRetweet = true
            }
            
            success()
        }, failure: { (error: Error) in
            failure(error)
        })
    }
}
