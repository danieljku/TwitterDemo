//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/19/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var coverPhotoImage: UIImageView!
    @IBOutlet weak var profilePhotoImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var profileDescription: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        //followButton.layer.borderColor = UIColor
        // Do any additional setup after loading the view.
        profilePhotoImage.layer.cornerRadius = 4
        profilePhotoImage.clipsToBounds = true
        profilePhotoImage.layer.borderWidth = 3
        profilePhotoImage.layer.borderColor = UIColor.white.cgColor
        
        coverPhotoImage.setImageWith((user?.coverPhotoUrl)!)
        profilePhotoImage.setImageWith((user?.profileUrl)!)
        username.text = user?.name
        
        var following = Double((user?.following)!)
        if following > 1000 && following < 1000000{
            following = following/1000.00
            followingCount.text = String(format: "%.1f K", following)
        }else if following > 1000000{
            following = following/1000000
            followingCount.text = String(format: "%.1f M", following)
        }else{
            followingCount.text = String(Int(following))
        }
        
        var followers = Double((user?.followers)!)
        if followers > 1000 && followers < 1000000{
            followers = followers/1000.00
            followersCount.text = String(format: "%.1f K", followers)
        }else if followers > 1000000{
            followers = followers/1000000
            followersCount.text = String(format: "%.1f M", followers)
        }else{
            followersCount.text = String(Int(followers))
        }

        profileDescription.text = user?.tagline
        screenName.text = "@\((user?.screenname)!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func followButton(_ sender: Any) {
    }


}
