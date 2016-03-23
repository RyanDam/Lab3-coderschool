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

    @IBOutlet weak var chatInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        let messageObject = PFObject(className: "Message_Swift_032016")
        messageObject["Text"] = chatInputField.text!
        messageObject["Username"] = PFUser.currentUser()?.username
        messageObject.saveInBackgroundWithBlock { (success: Bool, err: NSError?) in
            if success {
                print("Send message success")
            }
            else {
                print("Send message fail")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
