//
//  WeekdayIntroViewController.swift
//  workaday
//
//  Created by Adam Preston on 7/27/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit

class WeekdayIntroViewController: SurveyViewController  {
    
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
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelSurveyButtonTapped))
        
    }
    
    @IBAction func finishSurveyButtonTapped() {
        print("my button")
    }
    
    func cancelSurveyButtonTapped(sender: UIBarButtonItem) {
        
        let workdayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("activityStoryBoardID")
        
        let navigationController = UINavigationController(rootViewController: workdayViewController!)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // Be sure to pass around the ResearchNet object to any view controllers who may need it.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "toWeekdayQuestion" {
            if let destination = segue.destinationViewController as? WeekdayQuestionViewController {
                destination.surveyParamters = self.surveyParamters
            }
        }
    }
    



    
}