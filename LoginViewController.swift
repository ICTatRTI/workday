//
//  LoginViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/14/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchKit

class LoginViewController: UIViewController {


    
    /// This tasks presents the login step.
    private var loginTask: ORKTask {
        /*
         A login step view controller subclass is required in order to use the login step.
         The subclass provides the behavior for the login step forgot password button.
         */
        class LoginViewController : ORKLoginStepViewController {
            override func forgotPasswordButtonTapped() {
                let alertTitle = NSLocalizedString("Forgot password?", comment: "")
                let alertMessage = NSLocalizedString("Button tapped", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        /*
         A login step provides a form step that is populated with email and password fields,
         and a button for `Forgot password?`.
         */
        let loginTitle = NSLocalizedString("Login", comment: "")
        let loginStep = ORKLoginStep(identifier: String("login step"), title: loginTitle, text: "Login", loginViewControllerClass: LoginViewController.self)
        
        /*
         A wait step allows you to validate the data from the user login against your server before proceeding.
         */
        let waitTitle = NSLocalizedString("Logging in", comment: "")
        let waitText = NSLocalizedString("Please wait while we validate your credentials", comment: "")
        let waitStep = ORKWaitStep(identifier: String("wait_login"))
        waitStep.title = waitTitle
        waitStep.text = waitText
        
        return ORKOrderedTask(identifier: String("login stask"), steps: [loginStep, waitStep])
    }
    
    
}

extension LoginViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        switch reason {
        case .Completed:
            
            // put calls to back end here
            
            performSegueWithIdentifier("toStudy", sender: nil)
            
        case .Discarded, .Failed, .Saved:
            print("quit.")
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        print("appear.....")
        
        let taskViewController = ORKTaskViewController(task: loginTask, taskRunUUID: nil)
        taskViewController.delegate = self
        
        presentViewController(taskViewController, animated: true, completion: nil)
        
        
    }
    
}
