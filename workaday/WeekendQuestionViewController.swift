//
//  WeekendQuestionViewController.swift
//  workaday
//
//  Created by Adam Preston on 7/27/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchNet

class WeekendQuestionViewController: SurveyViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    var researchNet : ResearchNet!
    
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: button1, button2, button3)
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
            case Constants.VIGOROUSLY_ACTIVE_TAG:
                saveSurvey(Constants.VIGOROUSLY_ACTIVE_LABEL)
            case Constants.MODERATELY_ACTIVE_TAG:
                saveSurvey(Constants.MODERATELY_ACTIVE_LABEL)
            default:
                saveSurvey(Constants.NOT_ACTIVE_LABEL)
            }
        }
        
        if segue.identifier == "toWeekendPamQuestion" {
            if let destination = segue.destinationViewController as? PamViewController {
                destination.surveyParamters = self.surveyParamters
                destination.device_id = self.device_id
                destination.lat = self.lat
                destination.long = self.long
                destination.researchNet = self.researchNet
            }
        }
    }

    
    func saveSurvey(response: String){
        self.surveyParamters[Constants.WORK_TRANSPORTATION_QUESTION_LABEL] = response
    }
    
}