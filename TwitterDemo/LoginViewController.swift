//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 1/27/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: {
            print("I've logged in!")
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
        
        
        
    }

}

