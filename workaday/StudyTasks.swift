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
        
        // Puts Steps here
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }()
    
}