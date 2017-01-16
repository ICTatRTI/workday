//
//  WeekendIntroViewController.swift
//  workaday
//
//  Created by Adam Preston on 7/28/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchNet

class WeekendIntroViewController: SurveyViewController  {
    
    @IBOutlet weak var gettingStartedButton: UIButton!
    var researchNet : ResearchNet!
    
    @IBAction func toSurveyQuestions(_ segue: UIStoryboardSegue){
        performSegue(withIdentifier: "toWeekendQuestion", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelSurveyButtonTapped))
        
    }
    
    func cancelSurveyButtonTapped(_ sender: UIBarButtonItem) {
        
        let workdayViewController = self.storyboard?.instantiateViewController(withIdentifier: "activityStoryBoardID")
        
        let navigationController = UINavigationController(rootViewController: workdayViewController!)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    

    // Be sure to pass around the ResearchNet object to any view controllers who may need it.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWeekendQuestion" {
            if let destination = segue.destination as? WeekendQuestionViewController {
                destination.device_id = self.device_id
                destination.lat = self.lat
                destination.long = self.long
                destination.researchNet = self.researchNet
                
            }
        }
    }

}
