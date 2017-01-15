//
//  StudyTasks.swift
//  workaday
//
//  Created by Adam Preston on 4/13/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import ResearchKit



struct StudyTasks {

    static let surveyTask: ORKOrderedTask = {
        var steps = [ORKStep]()
        
        
        /*
         ╔═╗┌┬┐┌─┐┌─┐┌─┐
         ╚═╗ │ ├┤ ├─┘└─┐
         ╚═╝ ┴ └─┘┴  └─┘
         
         */
        
        
        // Instruction step
        let instructionStep = ORKInstructionStep(identifier: "intro")
        instructionStep.title = "Welcome to RTI's Work Study"
        instructionStep.text = "This survey can help us understand you at work"
        
        steps += [instructionStep]
        
        // First question
        let textChoiceOneText = NSLocalizedString("Drove own car", comment: "Drove own car")
        let textChoiceTwoText = NSLocalizedString("Biked", comment: "Biked")
        let textChoiceThreeText = NSLocalizedString("Walked/ran", comment: "Walked/ran")
        let textChoiceFourText = NSLocalizedString("Carpool/vanpool", comment: "Carpool/vanpool")
        let textChoiceFiveText = NSLocalizedString("Did not commute", comment: "Did not commute")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "drove" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText, value: "biked" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText, value: "walked" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText, value: "carpooled" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFiveText, value: "none" as NSCoding & NSCopying & NSObjectProtocol)
            ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "How did you get to work", title: "How did you get to work today?", answer: answerFormat)
        
        steps += [questionStep]
        
        
        
        // Return the task
        return ORKOrderedTask(identifier: "SurveyWeekdayTask", steps: steps)
    }()
    
    
    
    static let surveyWeekendTask: ORKOrderedTask = {
        var steps = [ORKStep]()
        
        
        // Instruction step
        let instructionStep = ORKInstructionStep(identifier: "intro")
        instructionStep.title = "Welcome to RTI's Work Study"
        instructionStep.text = "This survey can help us understand you on the weekend"
        
        steps += [instructionStep]
        
        
        let textChoiceOneText = NSLocalizedString("Vigorously active for at least 30 min", comment: "")
        let textChoiceTwoText = NSLocalizedString("Moderately active", comment: "")
        let textChoiceThreeText = NSLocalizedString("Not very active, sedentary activities preferred", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "active" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText, value: "medium" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText, value: "not" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: "activity level", title: "What best describes your activity level today?", answer: answerFormat)
        
        
        steps += [questionStep]
        
        
        
        
        
        // Return the task
        return ORKOrderedTask(identifier: "SurveyWeekendTask", steps: steps)

    }()
    
}
