//
//  PamViewController.swift
//  ema
//
//  Created by Adam Preston on 4/29/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchNet

class PamViewController: SurveyViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var finishNavigationButton: UIButton!
    var researchNet : ResearchNet!
    
    
    let identifier = "CellIdentifier"
    
    @IBAction func finishSurveyButtonTapped() {
        
        let indexPaths : NSArray = self.collectionView!.indexPathsForSelectedItems()!
        let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PamCollectionViewCell
        
        saveSurvey(cell.pamPhotoName)
        
        //Submit Survey
        researchNet.submitSurveyResponse({ (responseObject, error) in
            
            if error != nil {
                
                let errorMessage = "Unable to reach the server. Try again."
                let alert = UIAlertController(title: "Submission Error",
                    message: errorMessage, preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                
                // using tags to keep track of which survey we just done
                let defaults = NSUserDefaults.standardUserDefaults()
                if self.finishNavigationButton.tag == 1{
                    defaults.setObject(NSDate(), forKey: "weekday_timestamp")
                } else{
                    defaults.setObject(NSDate(), forKey: "weekend_timestamp")
                }
            
                
                let destinationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("studyViewController") as! UITabBarController
         
                let navigationViewController = destinationViewController.viewControllers!.first as! UINavigationController
                
                let activityViewController = navigationViewController.viewControllers.first as! ActivityViewController
                    activityViewController.researchNet = self.researchNet
                
                self.presentViewController(destinationViewController, animated: true, completion: nil)
                
                }

            
            }, device_id: device_id, lat: lat, long: long, response: surveyParamters)
        
          
    }
    
    func saveSurvey(response: String){
        self.surveyParamters[Constants.PAM_QUESTION_LABEL] = response
    }
    
    @IBAction func reloadImages() {
        
        finishNavigationButton.enabled = false
        finishNavigationButton.layer.borderColor = Constants.disabledColor.CGColor
        self.collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self;
        collectionView.dataSource = self
        
        finishNavigationButton.backgroundColor = UIColor.clearColor()
        finishNavigationButton.layer.cornerRadius = 5
        finishNavigationButton.layer.borderWidth = 1
        finishNavigationButton.contentEdgeInsets = UIEdgeInsetsMake(10,20,10,20)
        finishNavigationButton.layer.borderColor = Constants.disabledColor.CGColor
        finishNavigationButton.enabled = false

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PamCollectionViewCell

        if flag {
            cell.imageView.alpha = 0.6;
            cell.checkIcon.hidden = false;
            cell.backgroundCircle.hidden = false;
        } else {
            cell.imageView.alpha = 1.0;
            cell.checkIcon.hidden = true;
            cell.backgroundCircle.hidden = true;
        }
        
 
    }
    
}




// MARK:- UICollectionViewDataSource Delegate
extension PamViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! PamCollectionViewCell
        
        let random = arc4random() % 3 + 1;
        
        let file_name = NSString(format: "%d_%d.jpg",indexPath.row + 1,random)
        let name = NSString(format: "%d_%d",indexPath.row + 1,random)
        
        cell.pamPhotoName = name as String
        cell.imageView.image = UIImage(named: file_name.lowercaseString)
        cell.checkIcon.hidden = true;
        cell.checkIcon.image = UIImage(named:"check" )
        cell.backgroundCircle.hidden = true;
        cell.backgroundCircle.layer.cornerRadius = 12.0;
        cell.backgroundCircle.layer.borderWidth = 0.25;
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier: "PamHeaderView", forIndexPath: indexPath) as! PamHeaderView
            headerView.label.text = "Select the photo the best captures how you feel right now."
            
            return headerView
        default:
            //4
            fatalError("Unexpected element kind")
        }
    }
    
}




extension PamViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
        finishNavigationButton.enabled = true
        finishNavigationButton.layer.borderColor = Constants.enabledColor.CGColor
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)

    }
}
