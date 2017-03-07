//
//  TweetViewController.swift
//  Simple-Twitter-Client
//
//  Created by Nguyen Nam Long on 3/6/17.
//  Copyright © 2017 Nguyen Nam Long. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tweets = [Tweet]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        TwitterClient.shared?.getHomeTimeline(completion: { (tweets: [Tweet]?, error: Error?) in
            if let data =  tweets {
                self.tweets = data
            }
            
            self.tableView.reloadData()
            
        })
        
//        TwitterClient.sharedInstance.homeTimelineWithParams(nil, maxId: nil, completion: { (tweets, error) -> () in
//            self.tweets = tweets!
//            for tweet in self.tweets {
//                println("text: \(tweet.text), created: \(tweet.createdAt)")
//            }
//            self.tableView.reloadData()
//        })
//        
//        refreshControl?.endRefreshing()
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

extension TweetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        cell.contentLabel.numberOfLines = 0
        cell.contentLabel.sizeToFit()
        
        if indexPath.row == tweets.count - 1 {
            
//            loadingView.startAnimating()
//            notificationLabel.hidden = true
//            getMoreTweets()
            
        } else {
//            loadingView.stopAnimating()
        }
        
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = UIColor(red: 222/255, green: 243/255, blue: 255/255, alpha: 1.0)
//        } else {
//            cell.backgroundColor = UIColor.whiteColor()
//        }
        
        // Set full width for the separator
//        cell.layoutMargins = UIEdgeInsetsZero
//        cell.preservesSuperviewLayoutMargins = false
//        cell.separatorInset = UIEdgeInsetsZero
//        
        return cell
    }
}
