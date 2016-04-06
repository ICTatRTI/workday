//
//  ViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/6/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController, ORKTaskViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        
        let task = ORKOrderedTask(identifier: "task", steps: [workdayOneStep, workdayTwoStep, workdayThreeStep, workdayFourStep])
        
        let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
        taskViewController.delegate = self
        
        presentViewController(taskViewController, animated: true, completion: nil)
    }

    
    func taskViewController(taskViewController: ORKTaskViewController,
                            didFinishWithReason reason: ORKTaskViewControllerFinishReason,
                                                error: NSError?) {
        
        
        
        // Then, dismiss the task view controller.
        dismissViewControllerAnimated(true, completion: nil)
    }


    func taskResultFinishedCompletionHandler(_: ORKResult -> Void) {
        print("I am done")
    }
    
    
    
    /*
     ╔═╗┌┬┐┌─┐┌─┐┌─┐
     ╚═╗ │ ├┤ ├─┘└─┐
     ╚═╝ ┴ └─┘┴  └─┘
 
     */
    
    //Workday
    //How did you get to work today?
     private var workdayOneStep : ORKQuestionStep {
        
        let textChoiceOneText = NSLocalizedString("Bad", comment: "Not good at all")
        let textChoiceTwoText = NSLocalizedString("Fine", comment: "Whatever")
        let textChoiceThreeText = NSLocalizedString("Fantastic", comment: "Really good, actually")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "bad"),
            ORKTextChoice(text: textChoiceTwoText, value: "fine"),
            ORKTextChoice(text: textChoiceThreeText, value: "good")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "mood category", title: "How is your day going today?", answer: answerFormat)
        
        return questionStep
        
    }
    
    
    // How do you feel today?
    private var workdayTwoStep : ORKQuestionStep {
        
        
        let textChoiceOneText = NSLocalizedString("Bad", comment: "Not good at all")
        let textChoiceTwoText = NSLocalizedString("Fine", comment: "Whatever")
        let textChoiceThreeText = NSLocalizedString("Fantastic", comment: "Really good, actually")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "bad"),
            ORKTextChoice(text: textChoiceTwoText, value: "fine"),
            ORKTextChoice(text: textChoiceThreeText, value: "good")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "mood category", title: "How is your day going today?", answer: answerFormat)
        
        return questionStep

        
    }
    
    
    
    // Weekend
    //What best describes your activity level today?
    private var workdayThreeStep : ORKQuestionStep {
        
        
        let textChoiceOneText = NSLocalizedString("Bad", comment: "Not good at all")
        let textChoiceTwoText = NSLocalizedString("Fine", comment: "Whatever")
        let textChoiceThreeText = NSLocalizedString("Fantastic", comment: "Really good, actually")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "bad"),
            ORKTextChoice(text: textChoiceTwoText, value: "fine"),
            ORKTextChoice(text: textChoiceThreeText, value: "good")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "mood category", title: "How is your day going today?", answer: answerFormat)
        
        return questionStep
        
        
    }

    
    
    //How do you feel today?
    private var workdayFourStep : ORKQuestionStep {
        
        
        let textChoiceOneText = NSLocalizedString("Bad", comment: "Not good at all")
        let textChoiceTwoText = NSLocalizedString("Fine", comment: "Whatever")
        let textChoiceThreeText = NSLocalizedString("Fantastic", comment: "Really good, actually")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "bad"),
            ORKTextChoice(text: textChoiceTwoText, value: "fine"),
            ORKTextChoice(text: textChoiceThreeText, value: "good")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "mood category", title: "How is your day going today?", answer: answerFormat)
        
        return questionStep
        
        
    }


    
    

}

