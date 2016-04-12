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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            print("on to the study")
            // toStudy()
        }
        else {
            print("on to onboarding")
            toOnboarding()
        }
    }

    // MARK: Unwind segues
    
    @IBAction func unwindToStudy(segue: UIStoryboardSegue) {
        toStudy()
    }
    

    
    func toOnboarding() {
        performSegueWithIdentifier("toOnboarding", sender: self)
    }

    func toStudy() {
        performSegueWithIdentifier("toStudy", sender: self)
    }
    
    

}

