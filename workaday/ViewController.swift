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
        
        
        let task = ORKOrderedTask(identifier: "task", steps: [instructionStep,workdayOneStep, workdayTwoStep, workdayThreeStep, workdayFourStep,summaryStep])
        
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
    
    
    private var instructionStep : ORKInstructionStep {
        
        let instructionStep = ORKInstructionStep(identifier: "intro")
        instructionStep.title = "Welcome to RTI's Work Study"
        instructionStep.text = "This survey can help us understand you at work"
        
        return instructionStep
        
    }
    //Workday
    //How did you get to work today?
     private var workdayOneStep : ORKQuestionStep {
        
        let textChoiceOneText = NSLocalizedString("Drove own car", comment: "Drove own car")
        let textChoiceTwoText = NSLocalizedString("Biked", comment: "Biked")
        let textChoiceThreeText = NSLocalizedString("Walked/ran", comment: "Walked/ran")
        let textChoiceFourText = NSLocalizedString("Carpool/vanpool", comment: "Carpool/vanpool")
        let textChoiceFiveText = NSLocalizedString("Did not commute", comment: "Did not commute")
        
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "drove"),
            ORKTextChoice(text: textChoiceTwoText, value: "biked"),
            ORKTextChoice(text: textChoiceThreeText, value: "walked"),
            ORKTextChoice(text: textChoiceFourText, value: "carpooled"),
            ORKTextChoice(text: textChoiceFiveText, value: "none"),
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "How did you get to work", title: "How did you get to work today?", answer: answerFormat)
        
        return questionStep
        
    }
    
    
    // How do you feel today?
    private var workdayTwoStep : ORKQuestionStep {
        
        let textChoiceOneText = NSLocalizedString("Complete elated, rapturous joy and soaring ecstasy", comment: "")
        let textChoiceTwoText = NSLocalizedString("Very elated and in very high spirits. Tremendous delight and buoyancy", comment: "")
        let textChoiceThreeText = NSLocalizedString("Elated and in high spirits", comment: "")
        let textChoiceFourText = NSLocalizedString("Feeling very good and cheerful", comment: "")
        let textChoiceFiveText = NSLocalizedString("Feeling pretty good, 'OK'", comment: "")
        let textChoiceSixText = NSLocalizedString("Feeling a little bit low. Just so-so", comment: "")
        let textChoiceSevenText = NSLocalizedString("Spirits low and somewhat 'blue'", comment: "")
        let textChoiceEightText = NSLocalizedString("Depressed and feeling very low. Definitely 'blue'", comment: "")
        let textChoiceNineText = NSLocalizedString("Tremendously depressed. Feeling terrible, really miserable, 'just awful'", comment: "")
        let textChoiceTenText = NSLocalizedString("Utter depression and gloom. Completely down.", comment: "")
        let textChoiceElevenText = NSLocalizedString("All is black and leaden. Wish it were all over", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "10"),
            ORKTextChoice(text: textChoiceTwoText, value: "9"),
            ORKTextChoice(text: textChoiceThreeText, value: "8"),
            ORKTextChoice(text: textChoiceFourText, value: "7"),
            ORKTextChoice(text: textChoiceFiveText, value: "6"),
            ORKTextChoice(text: textChoiceSixText, value: "5"),
            ORKTextChoice(text: textChoiceSevenText, value: "4"),
            ORKTextChoice(text: textChoiceEightText, value: "3"),
            ORKTextChoice(text: textChoiceNineText, value: "2"),
            ORKTextChoice(text: textChoiceTenText, value: "1"),
            ORKTextChoice(text: textChoiceElevenText, value: "0")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "how do you feel today", title: "How do you feel today?", answer: answerFormat)
        

        
        return questionStep

        
    }
    
    
    
    // Weekend
    //What best describes your activity level today?
    private var workdayThreeStep : ORKQuestionStep {
        
        
        let textChoiceOneText = NSLocalizedString("Vigorously active for at least 30 min", comment: "")
        let textChoiceTwoText = NSLocalizedString("Moderately active", comment: "")
        let textChoiceThreeText = NSLocalizedString("Not very active, sedentary activities preferred", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "active"),
            ORKTextChoice(text: textChoiceTwoText, value: "medium"),
            ORKTextChoice(text: textChoiceThreeText, value: "not")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "activity level", title: "What best describes your activity level today?", answer: answerFormat)
        
        return questionStep
        
        
    }

    
    
    //How do you feel today?
    private var workdayFourStep : ORKQuestionStep {
        
        
        let textChoiceOneText = NSLocalizedString("Complete elated, rapturous joy and soaring ecstasy", comment: "")
        let textChoiceTwoText = NSLocalizedString("Very elated and in very high spirits. Tremendous delight and buoyancy", comment: "")
        let textChoiceThreeText = NSLocalizedString("Elated and in high spirits", comment: "")
        let textChoiceFourText = NSLocalizedString("Feeling very good and cheerful", comment: "")
        let textChoiceFiveText = NSLocalizedString("Feeling pretty good, 'OK'", comment: "")
        let textChoiceSixText = NSLocalizedString("Feeling a little bit low. Just so-so", comment: "")
        let textChoiceSevenText = NSLocalizedString("Spirits low and somewhat 'blue'", comment: "")
        let textChoiceEightText = NSLocalizedString("Depressed and feeling very low. Definitely 'blue'", comment: "")
        let textChoiceNineText = NSLocalizedString("Tremendously depressed. Feeling terrible, really miserable, 'just awful'", comment: "")
        let textChoiceTenText = NSLocalizedString("Utter depression and gloom. Completely down.", comment: "")
        let textChoiceElevenText = NSLocalizedString("All is black and leaden. Wish it were all over", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "10"),
            ORKTextChoice(text: textChoiceTwoText, value: "9"),
            ORKTextChoice(text: textChoiceThreeText, value: "8"),
            ORKTextChoice(text: textChoiceFourText, value: "7"),
            ORKTextChoice(text: textChoiceFiveText, value: "6"),
            ORKTextChoice(text: textChoiceSixText, value: "5"),
            ORKTextChoice(text: textChoiceSevenText, value: "4"),
            ORKTextChoice(text: textChoiceEightText, value: "3"),
            ORKTextChoice(text: textChoiceNineText, value: "2"),
            ORKTextChoice(text: textChoiceTenText, value: "1"),
            ORKTextChoice(text: textChoiceElevenText, value: "0")
        ]
        
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "how do you feel this week", title: "How do you feel today?", answer: answerFormat)
        
        
        
        return questionStep
        
        
    }


    private var summaryStep :ORKCompletionStep {
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Right. Off you go!"
        summaryStep.text = "That was easy!"
        
        return summaryStep
    }

    

}

