//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/22/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetText: UITextView!

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = User.currentUser

        profileImage.setImageWith((user?.profileUrl)!)
        tweetText.text = "What's happening?"
        tweetText.textColor = UIColor.gray
        tweetText.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetText.text = ""
        tweetText.textColor = UIColor.black
    }
    
    @IBAction func closeComposeTweet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func sendTweet(_ sender: Any) {
//        if tweetText.text == nil{
//            let textCheckAlert: UIAlertController = UIAlertController(title: "Text Check", message: "You didn't enter in a tweet!", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "OK",style: .cancel, handler: nil)
//            textCheckAlert.addAction(cancelAction)
//            self.present(textCheckAlert, animated: true, completion: nil)
//        }
        
        if let tweetText = tweetText.text{
            TwitterClient.sharedInstance?.postTweet(text: tweetText, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
}
