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
    let refreshControl = UIRefreshControl()
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        TwitterClient.shared?.getHomeTimeline(completion: { (tweets: [Tweet]?, error: Error?) in
            if let data =  tweets {
                self.tweets = data
            }
            
            self.tableView.reloadData()
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSignOut(_ sender: UIBarButtonItem) {
        TwitterClient.shared?.logOut()
        NotificationCenter.default.post(name: NSNotification.Name("userDidlogoutNofi"), object: nil)
        
    }
    
    
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.shared?.getHomeTimeline(completion: { (tweets: [Tweet]?, error: Error?) in
            if let data =  tweets {
                self.tweets = data
            }
            
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        })
    }

}




// MARK: - Table Delegate, DataSource
extension TweetViewController: UITableViewDelegate, UITableViewDataSource, TweetCellDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        cell.tweetItem = tweets[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func didFinishUpdate() {
        refreshControlAction(refreshControl)
    }
    
    func onRetweet() {
        loadData()
        
    }
    
    func onFavorite() {
        loadData()
    }
}
