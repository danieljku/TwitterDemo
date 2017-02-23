//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/14/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetDate: UILabel!

    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = ""
        
        //        self.navigationItem.hidesBackButton = true
        
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        
        profileImage.setImageWith((tweet?.profilePhotoUrl)!)
        username.text = tweet?.username
        tweetText.text = tweet?.text
        retweetCount.text = String(describing: (tweet?.retweetCount)!)
        likesCount.text = String(describing: (tweet?.favoritesCount)!)
        screenName.text = "@\((tweet?.screenName)!)"
        tweetDate.text = tweet?.timestamp
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TweetDetailViewController.imageTapped))
        self.profileImage.addGestureRecognizer(tapRecognizer)
        self.profileImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        let profileVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        profileVC.user = tweet?.tweetUser
        self.navigationController!.pushViewController(profileVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyButton(_ sender: Any) {
    }

    @IBAction func retweetButton(_ sender: Any) {
    }

    @IBAction func favoriteButton(_ sender: Any) {
    }
    
}
