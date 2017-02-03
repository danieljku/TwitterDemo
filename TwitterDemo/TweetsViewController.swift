//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeLineCell", for: indexPath) as! HomeLineTableViewCell
        let tweet = tweets[indexPath.row]
        
        cell.username.text = tweet.username as String?
        cell.timeStamp.text = tweet.timestamp
        cell.tweetText.text = tweet.text as String?
        cell.favoriteCount.text = String(describing: tweet.favoritesCount!)
        cell.retweetCount.text = String(describing: tweet.retweetCount!)
        cell.profilePhoto.setImageWith(tweet.profilePhotoUrl as! URL)
        
        
        return cell
    }

    @IBAction func onFavorite(_ sender: Any) {
        
    }
    
    @IBAction func onRetweet(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }


}
