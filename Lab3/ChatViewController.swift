//
//  ChatViewController.swift
//  Lab3
//
//  Created by Dam Vu Duy on 3/23/16.
//  Copyright © 2016 dotRStudio. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var tbvChat: UITableView!
    @IBOutlet weak var chatInputField: UITextField!
    
    var chatDatas: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvChat.estimatedRowHeight = 50;
        tbvChat.rowHeight = UITableViewAutomaticDimension
        
        tbvChat.delegate = self
        tbvChat.dataSource = self
        
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:"onTimer", userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        let messageObject = PFObject(className: "Message_Swift_032016")
        messageObject["text"] = chatInputField.text!
        messageObject["username"] = PFUser.currentUser()?.username
        

        
        messageObject.saveInBackgroundWithBlock { (success: Bool, err: NSError?) in
            if success {
                print("Send message success")
            }
            else {
                print("Send message fail")
            }
        }
    }

    func onTimer () {
        let query = PFQuery(className:"Message_Swift_032016")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                if let objects = objects {
                    self.chatDatas = objects
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tbvChat.reloadData()
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

}
//MARK: - ExtensionTableView
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    //tableViewDatasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
        cell.lblMessage.text = self.chatDatas![indexPath.row]["text"] as? String
        cell.lblUserName.text = self.chatDatas![indexPath.row]["username"] as? String
        return cell
    }
    //tableViewDelegate
}

