//
//  ViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/6/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchKit
import ResearchNet

class ViewController: UIViewController {

    // Configure researchnet
    var researchNet : ResearchNet = ResearchNet(host: "researchnet.ictedge.org", appKey: "9a1194980e9e15da451d9ab68a5b8801e6704c18")


    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.stringForKey("authKey") != nil) {
            toStudy()
        } else {
            toOnboarding()
        }
    }
    
    // Be sure to pass around the ResearchNet object to any view controllers who may need it.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toOnboarding" {
            if let destination = segue.destinationViewController as? OnboardingViewController {
                destination.researchNet = self.researchNet
            }
        }
        
        if segue.identifier == "toStudy" {
          
            if let destination = segue.destinationViewController as? UITabBarController {
                let navigationViewController = destination.viewControllers!.first as! UINavigationController
                let activityViewController = navigationViewController.viewControllers.first as! ActivityViewController
                activityViewController.researchNet = self.researchNet
            }
        }
    }
    
    
    @IBAction func unwindToStudy(segue: UIStoryboardSegue) {
        toStudy()
    }
    
    @IBAction func unwindToWithdrawl(segue: UIStoryboardSegue) {
        toWithdrawl()
    }
    
    @IBAction func unwindToOnboarding(segue: UIStoryboardSegue) {
        toOnboarding()
    }
    
    // MARK: Transitions
    
    func toOnboarding() {
        performSegueWithIdentifier("toOnboarding", sender: self)
    }

    func toStudy() {
        performSegueWithIdentifier("toStudy", sender: self)
    }

    
    func toWithdrawl() {
        let viewController = WithdrawViewController()
        viewController.delegate = self
        
        presentViewController(viewController, animated: true, completion: nil)
    }
    
}


extension ViewController: ORKTaskViewControllerDelegate {
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        // Check if the user has finished the `WithdrawViewController`.
        if taskViewController is WithdrawViewController {
            /*
             If the user has completed the withdrawl steps, remove them from
             the study and transition to the onboarding view.
             */
            if reason == .Completed {
                ORKPasscodeViewController.removePasscodeFromKeychain()
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.removeObjectForKey("authKey")
                
                // Call backend to disable user
                
                toOnboarding()
            }
            
            // Dismiss the `WithdrawViewController`.
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

