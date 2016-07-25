//
//  LoginViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/14/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchKit
import ResearchNet


class LoginViewController: UIViewController {

    var researchNet : ResearchNet!
    let LOGIN_STEP_IDENTIFIER : String = "login step"
    let WAIT_STEP_IDENTIFIER : String = "wait step"
    let LOGIN_TASK_NAME : String = "login task"
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToStudy" {
            if let destination = segue.destinationViewController as? ActivityViewController {
                destination.researchNet = self.researchNet
            }
        }
    }


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
        let loginStep = ORKLoginStep(identifier: String(LOGIN_STEP_IDENTIFIER), title: loginTitle, text: "", loginViewControllerClass: LoginViewController.self)
        
        /*
         A wait step allows you to validate the data from the user login against your server before proceeding.
         */
        let waitTitle = NSLocalizedString("Logging in", comment: "")
        let waitText = NSLocalizedString("Please wait while we validate your credentials", comment: "")
        let waitStep = ORKWaitStep(identifier: String(WAIT_STEP_IDENTIFIER))
        waitStep.title = waitTitle
        waitStep.text = waitText

        
        return ORKOrderedTask(identifier: String(LOGIN_TASK_NAME), steps: [loginStep, waitStep])
    }
    
    
    // MARK: Transitions
    
    func toStudy() {
        performSegueWithIdentifier("unwindToStudy", sender: nil)
    }
    
}

extension LoginViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        switch reason {
        
        case .Completed:
            
            self.toStudy()
            
        case .Discarded, .Failed, .Saved:

            dismissViewControllerAnimated(true, completion: nil)
            performSegueWithIdentifier("unwindToOnboarding", sender: nil)
           
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {

        let taskViewController = ORKTaskViewController(task: loginTask, taskRunUUID: nil)
        taskViewController.delegate = self
        
        presentViewController(taskViewController, animated: true, completion: nil)
        
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        

            if let stepViewController = stepViewController as? ORKWaitStepViewController {
                
                
                let taskViewControllerResult = taskViewController.result
                //let results = taskViewControllerResult.results as! [ORKStepResult]
         
                // Login
                let login_step = taskViewControllerResult.stepResultForStepIdentifier(LOGIN_STEP_IDENTIFIER)
                    
                let stepResults = login_step!.results as! [ORKQuestionResult]
                let usernameResult = stepResults[0] as? ORKTextQuestionResult
                let passwordResult = stepResults[1] as? ORKTextQuestionResult
                        
                // Call using a closure parameter
                researchNet.authenticateUser({ (responseObject, error) in
                            
                    if error != nil {
                        let errorMessage = "Your username and password didn't match. Try again."
                        
                        let alert = UIAlertController(title: "Login Error",
                            message: errorMessage, preferredStyle: .Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: {
                            (alert: UIAlertAction!) in stepViewController.goBackward()
                        })
                        alert.addAction(action)
                        taskViewController.presentViewController(alert, animated: true, completion: nil)

                    } else{

                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(responseObject!, forKey: "authKey")
                        
                        stepViewController.goForward()
                    }
                    
                    }, username: usernameResult?.textAnswer, password: passwordResult?.textAnswer)
            }

    }
    
}
