//
//  ViewController.swift
//  Lab3
//
//  Created by Dam Vu Duy on 3/23/16.
//  Copyright © 2016 dotRStudio. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSignUp(sender: AnyObject) {
        let user = PFUser()
        user.username = lblEmail.text
        user.password = lblPassword.text
        user.email = lblEmail.text
        // other fields can be set just like with PFObject
//        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                self.showMessage(errorString as! String)
            } else {
                print("Sign up success")
                let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatViewController")
                self.presentViewController(chatVC, animated: true, completion: {
                    //
                })
                
            }
        }
    }
    
    @IBAction func onLogIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(lblEmail.text! , password:lblPassword.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Log in success")
                let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatViewController")
                self.presentViewController(chatVC, animated: true, completion: {
                    //
                })
            } else {
                self.showMessage("Fail!")
            }
        }
    }
    
    func showMessage(string :String){
        let alert =   UIAlertController(title: "Alert", message: string, preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (gy:UIAlertAction) -> Void in
        }
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil)

    }
}

