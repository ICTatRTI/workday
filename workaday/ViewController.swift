//
//  ViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/6/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            print("on to the study")
        }
        else {
            print("on to onboarding")
            toOnboarding()
        }
    }

    
    func toOnboarding() {
        performSegueWithIdentifier("toOnboarding", sender: self)
    }


    
    

}

