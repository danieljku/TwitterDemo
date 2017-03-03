//
//  HomeLineTableViewCell.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

protocol ProfileTapDelegate: class {
    func profileTapped(_ cell: HomeLineTableViewCell, user: User)
}

class HomeLineTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePhoto: UIImageView!{
        didSet{
            let profileImageTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTap(_:)))
            self.profilePhoto.addGestureRecognizer(profileImageTapRecognizer)
            self.profilePhoto.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var retweetUser: UILabel!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    //@IBOutlet weak var replyCount: UILabel!

    weak var delegate : ProfileTapDelegate?

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
                retweetUser.isHidden = true
                retweetImage.isHidden = true
            }else{
                retweetUser.isHidden = false
                retweetImage.isHidden = false
                retweetUser.text = "\((tweet.retweetedUsername)!) Retweeted"
            }
        }
    }
    
    func profileTap(_ gesture: UITapGestureRecognizer) {
        self.delegate?.profileTapped(self, user: tweet.tweetUser!)
    }
    
    @IBAction func onReply(_ sender: Any) {
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        self.tweet.updateRetweet(success: {
            if self.tweet.didRetweet == false{
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }else{
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }
            self.retweetCount.text = "\(self.tweet.retweetCount!)"
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        self.tweet.updateFavorite(success: {
            if self.tweet.didFavorite == false{
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }else{
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }
            self.favoriteCount.text = "\(self.tweet.favoritesCount!)"
        }) { (error: Error) in
            print(error)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
