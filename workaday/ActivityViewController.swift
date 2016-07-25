//
//  ActivityViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/13/16.
//  Copyright © 2016 RTI. All rights reserved.
//


import UIKit
import ResearchKit
import ResearchNet

enum Activity: Int {
    case WeekdaySurvey, WeekendSurvey
    
    static var allValues: [Activity] {
        var idx = 0
        return Array(
            AnyGenerator{
                return self.init(rawValue: idx++)})
    }
    
    var title: String {
        switch self {
        case .WeekdaySurvey:
            return "Weekday Survey"
        case .WeekendSurvey:
            return "Weekend Survey"
        }
    }
    
    var subtitle: String {
        switch self {
        case .WeekdaySurvey:
            return "Answer 6 short questions"
        case .WeekendSurvey:
            return "Voice evaluation"
        }
    }
}



class ActivityViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    var researchNet : ResearchNet!
    var locationManager: CLLocationManager!
    var locationFixAchieved : Bool = false
    var txtLatitude: Double = 0.0
    var txtLongitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Try to get users location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationFixAchieved = false
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as! CLLocation
            let coord = locationObj.coordinate
            
            txtLatitude = coord.latitude
            txtLongitude = coord.longitude
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        
        return Activity.allValues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath)
        
        if let activity = Activity(rawValue: indexPath.row) {
            
            //put checkbox logic here
            cell.textLabel?.text = activity.title
            cell.detailTextLabel?.text = activity.subtitle
            
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRowsInSection(section)
        
        // Set the check mark on "completed" tasks
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) {
                
                cell.accessoryType =  .Checkmark
                //cell.selectionStyle = UITableViewCellSelectionStyle.None
            }
        }
        
        guard let activity = Activity(rawValue: indexPath.row) else { return }
        
        let taskViewController: ORKTaskViewController
        switch activity {
        case .WeekdaySurvey:
            taskViewController = ORKTaskViewController(task: StudyTasks.surveyTask, taskRunUUID: NSUUID())
        case .WeekendSurvey:
            taskViewController = ORKTaskViewController(task: StudyTasks.surveyWeekendTask, taskRunUUID: NSUUID())

        }
        
        taskViewController.delegate = self
        navigationController?.presentViewController(taskViewController, animated: true, completion: nil)
    }
}

extension ActivityViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        // Handle results using taskViewController.result
         let defaults = NSUserDefaults.standardUserDefaults()
        
        //write task name and complete date to local storage
        if taskViewController.task?.identifier == "SurveyWeekdayTask" {
            defaults.setObject(NSDate(), forKey: "weekday_timestamp")
             print("yes SurveyWeekdayTask")
            //destination.researchNet = self.researchNet
        } else{
            defaults.setObject(NSDate(), forKey: "weekend_timestamp")
            print("yes SurveyWeekendTask")
        }

        let device_id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let taskResult = taskViewController.result // this should be a ORKTaskResult
        let results = taskResult.results as! [ORKStepResult]//[ORKStepResult]
        var responses: [String:String] = [:]
        
        for thisStepResult in results { // [ORKStepResults]
            
            let stepResults = thisStepResult.results as! [ORKQuestionResult]
            
            /*
             Go through the supported answer formats.  This is made easier with AppCore but we're not using this for now just because a) its in objective C and kind of hard to use and 2) its going away at some point to be replaced with enhancements to the ResearchKit framework
             
             */
            if let scaleresult = stepResults.first as? ORKScaleQuestionResult
            {
                if scaleresult.scaleAnswer != nil
                {
                    responses[scaleresult.identifier] = (scaleresult.scaleAnswer?.stringValue)!
                }
            }
            
            if let choiceresult = stepResults.first as? ORKChoiceQuestionResult
            {
                if choiceresult.choiceAnswers != nil
                {
                    let selected = choiceresult.choiceAnswers!
                    responses[choiceresult.identifier] = "\(selected.first!)"
                }
            }
        }
        

        
        researchNet.submitSurveyResponse({ (responseObject, error) in
            
             if error != nil {
                
                
                print("there was an error ")
             } else {
                print("there wasn't an error. good job!")
             }
            
            
            
            }, device_id: device_id, lat: String(txtLatitude), long: String(txtLongitude), response: responses)
        

        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
