//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "y7u1hRHccLMY1paB3Ve3OgAVk", consumerSecret: "XhBkKJZKi7WX3AyY1Xy3QqF4AWPc0PApU68by5bPYrLMMZ5b3y")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mytwitterdemo://oauth"), scope: nil, success: { ( requestToken: BDBOAuth1Credential?) in
            let token = (requestToken?.token)!
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")
            UIApplication.shared.open(url!, options: [:], completionHandler: { (check: Bool) in
                print(check)
            })
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure!(error as! NSError)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) in
                self.loginFailure!(error as NSError)
            })
            
            
        }, failure: { (error: Error?) in
            print("error\(error?.localizedDescription)")
            self.loginFailure!(error as! NSError)
        })
        
    }
    
    func retweet(tweet: Tweet, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        if let tweetID = tweet.tweetID{
            let action: String = tweet.didRetweet! ? "unretweet" : "retweet"
            post("1.1/statuses/\(action)/\(tweetID).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
                
                success()
                
            }) { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        }
    }
    
    func favorite(tweet: Tweet, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        if let tweetID = tweet.tweetID{
            let action: String = tweet.didFavorite! ? "destroy" : "create"
            post("1.1/favorites/\(action).json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
                
                success()

            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            })
        }
    }
    
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), offset: Int?, failure: @escaping (NSError) -> ()){
        var parameter: [String: AnyObject]?
        
        if offset != nil{
            parameter = ["count": offset as AnyObject]
        }
        get("1.1/statuses/home_timeline.json", parameters: parameter, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
}
