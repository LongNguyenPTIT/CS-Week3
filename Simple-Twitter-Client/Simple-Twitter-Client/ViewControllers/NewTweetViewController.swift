//
//  NewTweetViewController.swift
//  Simple-Twitter-Client
//
//  Created by Nguyen Nam Long on 3/10/17.
//  Copyright © 2017 Nguyen Nam Long. All rights reserved.
//

import UIKit


class NewTweetViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var newTweetTextField: UITextView!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTweetTextField.delegate = self
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
    @IBAction func onCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onNewTweet(_ sender: UIButton) {
        TwitterClient.shared?.updateNewTweet(tweet: newTweetTextField.text, completion: { (result, error) in
            if (result != nil) {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    

}

extension NewTweetViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if newTweetTextField.text.contains("What's happening?") {
            newTweetTextField.text = ""
        }
    }
    
}
