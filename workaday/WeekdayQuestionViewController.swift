//
//  WeekdayQuestionViewController.swift
//  workaday
//
//  Created by Adam Preston on 7/27/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit


class WeekdayQuestionViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: button1, button2, button3, button4, button5, button6)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        // Style the done button (simliar to RK)
        doneButton.backgroundColor = UIColor.clearColor()
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderWidth = 1
        doneButton.contentEdgeInsets = UIEdgeInsetsMake(10,20,10,20)
        
        let swiftColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        doneButton.layer.borderColor = swiftColor.CGColor

    }

    
    // Be sure to pass around the ResearchNet object to any view controllers who may need it.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       
        
        if let selectedButton = radioButtonController?.selectedButton() {
            
            switch selectedButton.tag {
            case Constants.DROVE_OWN_CAR_TAG:
                print(Constants.DROVE_OWN_CAR_LABEL)
            case Constants.BIKED_TAG:
                print(Constants.BIKED_LABEL)
            case Constants.WALKED_RAN_TAG:
                print(Constants.WALKED_RAN_LABEL)
            case Constants.CARPOOL_TAG:
                print(Constants.CARPOOL_LABEL)
            case Constants.OTHER_COMMUTE_TAG:
                print(Constants.OTHER_COMMUTE_LABEL)
            default:
                print("nothing")
            }

        }
        
        
        
        if segue.identifier == "toWeekdayPamQuestion" {
             print("on to pam scene")
        }
    }
    
    
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }
    
    
}

