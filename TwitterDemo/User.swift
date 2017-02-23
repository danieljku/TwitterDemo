//
//  User.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    var userID: String?
    var followers: Int?
    var following: Int?
    var coverPhotoUrl: URL?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        let coverUrlString = dictionary["profile_banner_url"] as? String
        if let coverUrlString = coverUrlString{
            coverPhotoUrl = URL(string: coverUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
        if let id = dictionary["id_str"] as? String{
            userID = id
        }
        
        followers = (dictionary["followers_count"] as? Int) ?? 0
        following = (dictionary["friends_count"] as? Int) ?? 0
    }
    
    static var userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData{
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.set(nil, forKey: "currentUserData")

            }
            
            defaults.synchronize()
        }
    }
}
