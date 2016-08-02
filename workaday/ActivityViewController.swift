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
import CoreLocation

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
            return Constants.WEEKDAY_SURVEY_TITLE
        case .WeekendSurvey:
            return Constants.WEEKEND_SURVEY_TITLE
        }
    }
    
    var subtitle: String {
        switch self {
        case .WeekdaySurvey:
            return Constants.WEEKDAY_SURVEY_SUBTITLE
        case .WeekendSurvey:
            return Constants.WEEKEND_SURVEY_SUBTITLE
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
        
        self.tableView.reloadData()
   
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let weekday_ts = defaults.objectForKey("weekday_timestamp") as! NSDate
        let weekend_ts = defaults.objectForKey("weekend_timestamp") as! NSDate

        
        let currentDateTime = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: currentDateTime)
        let weekDay = myComponents.weekday
        
                
        if let activity = Activity(rawValue: indexPath.row) {
            
            //put checkbox logic here
            cell.textLabel?.text = activity.title
            cell.detailTextLabel?.text = activity.subtitle
            
            // restrict user from taking the survey more than once a day for weekday 
            // survey or once a week for weekend survey
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            /*
             Enable weekday survey on M-F only if the survey hasnt' been completed within
             the past 24 hours
             */
            if (activity.title == Constants.WEEKDAY_SURVEY_TITLE ){
                
                if ( weekDay == 1 || weekDay == 7) {
                    cell.accessoryType =  .Checkmark
                    cell.selectionStyle = .None
                    cell.userInteractionEnabled = false
                } else {
                    
                    if (weekday_ts.numberOfDaysUntilDateTime(currentDateTime) < 1 ){
                        cell.accessoryType =  .Checkmark
                        cell.selectionStyle = .None
                        cell.userInteractionEnabled = false
                    }
                }
        
                
            }
            /*
              Enable weekend survey on Sat/Sun only if the survey hasn't been completed within
             the past 24 hours
            */
            else if ( activity.title == Constants.WEEKEND_SURVEY_TITLE ){
                
                if (weekDay == 2 || weekDay == 3 || weekDay == 4 || weekDay == 5 || weekDay == 6) {
                    
                    cell.accessoryType =  .Checkmark
                    cell.selectionStyle = .None
                    cell.userInteractionEnabled = false
                
                } else  {
                    
                    if (weekend_ts.numberOfDaysUntilDateTime(currentDateTime) < 1 ){
                        cell.accessoryType =  .Checkmark
                        cell.selectionStyle = .None
                        cell.userInteractionEnabled = false

                    }
                    
                }
                
            }
  
        }
        
        return cell
    }
    
    

    
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let activity = Activity(rawValue: indexPath.row) else { return }
        

        switch activity {
        case .WeekdaySurvey:
           
            let workdayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weekdayStoryboardID") as! WeekdayIntroViewController
            
            //Set some required survye variables
            workdayViewController.device_id = UIDevice.currentDevice().identifierForVendor!.UUIDString
            workdayViewController.lat = String(txtLatitude)
            workdayViewController.long = String(txtLongitude)
            workdayViewController.researchNet = self.researchNet
            
            let navigationController = UINavigationController(rootViewController: workdayViewController)
            
            self.presentViewController(navigationController, animated: true, completion: nil)
            
        
        case .WeekendSurvey:
            
            let workdayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weekendStoryboardID") as! WeekendIntroViewController
            
            //Set some required survye variables
            workdayViewController.device_id = UIDevice.currentDevice().identifierForVendor!.UUIDString
            workdayViewController.lat = String(txtLatitude)
            workdayViewController.long = String(txtLatitude)
            workdayViewController.researchNet = self.researchNet

            
            let navigationController = UINavigationController(rootViewController: workdayViewController)
            
            self.presentViewController(navigationController, animated: true, completion: nil)

        }
        

    }
}

// Used for survey implementions with ResearchKit
extension ActivityViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {

        //write task name and complete date to local storage
        let defaults = NSUserDefaults.standardUserDefaults()
        if taskViewController.task?.identifier == "SurveyWeekdayTask" {
            defaults.setObject(NSDate(), forKey: "weekday_timestamp")
        } else{
            defaults.setObject(NSDate(), forKey: "weekend_timestamp")
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
        
        
        // Submit results
        researchNet.submitSurveyResponse({ (responseObject, error) in

             if error != nil {
                
                let errorMessage = "Unable to reach the server. Try again."
                
                let alert = UIAlertController(title: "Submission Error",
                    message: errorMessage, preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: {
                    (alert: UIAlertAction!) in taskViewController.goBackward()
                })
                alert.addAction(action)
                taskViewController.presentViewController(alert, animated: true, completion: nil)
                
             } else {
                taskViewController.dismissViewControllerAnimated(true, completion: nil)
             }
            
            }, device_id: device_id, lat: String(txtLatitude), long: String(txtLongitude), response: responses)
        

        
        
    }
}
