//
//  WeekdayIntroViewController.swift
//  workaday
//
//  Created by Adam Preston on 7/27/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit

class WeekdayIntroViewController: UIViewController  {
    
    @IBOutlet weak var gettingStartedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style the done button (simliar to RK)
        gettingStartedButton.backgroundColor = UIColor.clearColor()
        gettingStartedButton.layer.cornerRadius = 5
        gettingStartedButton.layer.borderWidth = 1
        gettingStartedButton.contentEdgeInsets = UIEdgeInsetsMake(10,20,10,20)
        
        let swiftColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        gettingStartedButton.layer.borderColor = swiftColor.CGColor
        
    }
}