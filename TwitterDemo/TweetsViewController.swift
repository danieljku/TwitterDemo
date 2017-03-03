//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Daniel Ku on 2/3/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let titleView = UIImageView(image: #imageLiteral(resourceName: "TwitterLogoBlue"))
        titleView.frame.size = CGSize(width: 40, height: 40)
        titleView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleView
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, offset: nil, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            refreshControl.endRefreshing()

        }, offset: nil, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func composeTweet(_ sender: Any) {
        let composeVC = self.storyboard!.instantiateViewController(withIdentifier: "composeTweet") as! ComposeTweetViewController
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TweetDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let tweetDetailVC = segue.destination as! TweetDetailViewController
            tweetDetailVC.tweet = tweet
        }
    }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource{
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
        cell.delegate = self
        cell.tweet = tweet
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TweetsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadingMoreView!.startAnimating()
                
                TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
                    self.tweets.append(contentsOf: tweets)
                    
                    self.isMoreDataLoading = false
                    self.loadingMoreView!.stopAnimating()
                    
                    self.tableView.reloadData()
                },offset: tweets.count, failure: { (error: NSError) in
                    print(error.localizedDescription)
                })
            }
        }
    }
}

extension TweetsViewController: ProfileTapDelegate{
    func profileTapped(_ cell: HomeLineTableViewCell, user: User) {
        let profileVC = self.storyboard!.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
        profileVC.user = user
        self.navigationController!.pushViewController(profileVC, animated: true)
    }
}
