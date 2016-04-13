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
        
        
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }()
    
}