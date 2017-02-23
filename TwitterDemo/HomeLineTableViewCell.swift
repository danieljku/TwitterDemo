//
//  HomeLineTableViewCell.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

protocol ProfileTapDelegate: class {
    func profileTap(_ cell: HomeLineTableViewCell)
}

class HomeLineTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var retweetUser: UILabel!
    @IBOutlet weak var retweetUserStackView: UIStackView!
    //@IBOutlet weak var replyCount: UILabel!

    var delegate : ProfileTapDelegate?

    var tweet: Tweet!{
        didSet{
            profilePhoto.setImageWith(tweet.profilePhotoUrl!)
            username.text = tweet.username
            tweetText.text = tweet.text
            timeStamp.text = tweet.timestamp
            retweetCount.text = String(tweet.retweetCount!)
            favoriteCount.text = String(tweet.favoritesCount!)
            screenName.text = "@\(tweet.screenName!)"
            if tweet.retweetedUsername == nil{
                retweetUserStackView.isHidden = true
                retweetUser.numberOfLines = 0
            }else{
                retweetUserStackView.isHidden = false
                retweetUser.text = "\((tweet.retweetedUsername)!) Retweeted"
            }
        }
    }
    
    func profileTap() {
        self.delegate?.profileTap(self)
    }
    
    @IBAction func onReply(_ sender: Any) {
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        self.tweet.updateRetweet(success: {
            self.retweetCount.text = "\(self.tweet.retweetCount!)"
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        self.tweet.updateFavorite(success: { 
            self.favoriteCount.text = "\(self.tweet.favoritesCount!)"
        }) { (error: Error) in
            print(error)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let profileImageTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeLineTableViewCell.profileTap))
        self.profilePhoto.addGestureRecognizer(profileImageTapRecognizer)
        self.profilePhoto.isUserInteractionEnabled = true
        
        profilePhoto.layer.cornerRadius = 3
        profilePhoto.clipsToBounds = true
        // Do any additional setup after loading the view.
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
