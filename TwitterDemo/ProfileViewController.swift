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
    @IBOutlet weak var tweetsCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
