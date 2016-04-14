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

class MainViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    @IBAction func joinStudy() {
    }
    
    @IBAction func login() {
    }
    
    @IBAction func showAlert() {
    }

}

