//
//  WeekdayQuestionViewController.swift
//  workaday
//
//  Created by Adam Preston on 7/27/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchNet


class WeekdayQuestionViewController: SurveyViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    var researchNet : ResearchNet!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: button1, button2, button3, button4, button5, button6)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        doneButton.backgroundColor = UIColor.clear
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderWidth = 1
        doneButton.contentEdgeInsets = UIEdgeInsetsMake(10,20,10,20)
        doneButton.layer.borderColor = Constants.disabledColor.cgColor
        doneButton.isEnabled = false
    }

    func didSelectButton(_ aButton: UIButton?) {
        
        if aButton != nil {
            doneButton!.isEnabled = true
            doneButton.layer.borderColor = Constants.enabledColor.cgColor
            
        } else {
            doneButton!.isEnabled = false
            doneButton.layer.borderColor = Constants.disabledColor.cgColor
            
        }
    }
    
    // Be sure to pass around the ResearchNet object to any view controllers who may need it.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedButton = radioButtonController?.selectedButton() {
            
            switch selectedButton.tag {
            case Constants.DROVE_OWN_CAR_TAG:
                saveSurvey(Constants.DROVE_OWN_CAR_LABEL)
            case Constants.BIKED_TAG:
                saveSurvey(Constants.BIKED_LABEL)
            case Constants.WALKED_RAN_TAG:
                saveSurvey(Constants.WALKED_RAN_LABEL)
            case Constants.CARPOOL_TAG:
                saveSurvey(Constants.CARPOOL_LABEL)
            case Constants.OTHER_COMMUTE_TAG:
                saveSurvey(Constants.OTHER_COMMUTE_LABEL)
            default:
                saveSurvey(Constants.NO_COMMUTE_LABEL)
            }

        }
  
        if segue.identifier == "toWeekdayPamQuestion" {
            if let destination = segue.destination as? PamViewController {
                destination.surveyParamters = self.surveyParamters
                destination.device_id = self.device_id
                destination.lat = self.lat
                destination.long = self.long
                destination.researchNet = self.researchNet
            }
        }
    }
    
    func saveSurvey(_ response: String){
        self.surveyParamters[Constants.WORK_TRANSPORTATION_QUESTION_LABEL] = response
    }
    
    
}

