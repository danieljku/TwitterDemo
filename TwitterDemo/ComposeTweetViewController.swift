//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/22/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var tweetCount: UILabel!

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
    
    @IBAction func closeComposeTweet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func sendTweet(_ sender: Any) {
        if let tweetText = tweetText.text{
            TwitterClient.sharedInstance?.postTweet(text: tweetText, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
}
extension ComposeTweetViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        tweetCount.text = "\(140 - newText.characters.count)"
        let numberOfChars = newText.characters.count
        return numberOfChars < 140;
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetText.text = ""
        tweetText.textColor = UIColor.black
    }
}
