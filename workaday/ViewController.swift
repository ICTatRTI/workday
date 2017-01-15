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

        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "authKey") != nil) {
            toStudy()
        } else {
            toOnboarding()
        }
    }
    
    // Be sure to pass around the ResearchNet object to any view controllers who may need it.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOnboarding" {
            if let destination = segue.destination as? OnboardingViewController {
                destination.researchNet = self.researchNet
            }
        }
        
        if segue.identifier == "toStudy" {
          
            if let destination = segue.destination as? UITabBarController {
                let navigationViewController = destination.viewControllers!.first as! UINavigationController
                let activityViewController = navigationViewController.viewControllers.first as! ActivityViewController
                activityViewController.researchNet = self.researchNet
            }
        }
    }
    
    
    @IBAction func unwindToStudy(_ segue: UIStoryboardSegue) {
        toStudy()
    }
    
    @IBAction func unwindToWithdrawl(_ segue: UIStoryboardSegue) {
        toWithdrawl()
    }
    
    @IBAction func unwindToOnboarding(_ segue: UIStoryboardSegue) {
        toOnboarding()
    }
    
    // MARK: Transitions
    
    func toOnboarding() {
        performSegue(withIdentifier: "toOnboarding", sender: self)
    }

    func toStudy() {
        performSegue(withIdentifier: "toStudy", sender: self)
    }

    
    func toWithdrawl() {
        let viewController = WithdrawViewController()
        viewController.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
}


extension ViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        // Check if the user has finished the `WithdrawViewController`.
        if taskViewController is WithdrawViewController {
            /*
             If the user has completed the withdrawl steps, remove them from
             the study and transition to the onboarding view.
             */
            if reason == .completed {
                ORKPasscodeViewController.removePasscodeFromKeychain()
                
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "authKey")
                
                // Call backend to disable user
                
                toOnboarding()
            }
            
            // Dismiss the `WithdrawViewController`.
            dismiss(animated: true, completion: nil)
        }
    }
}

