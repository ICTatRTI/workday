//
//  PamViewController.swift
//  ema
//
//  Created by Adam Preston on 4/29/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit

class PamViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var finishNavigationButton: UIBarButtonItem!

    let identifier = "CellIdentifier"
    
    @IBAction func finishSurveyButtonTapped() {
        
        //self.collectionView!.indexPathForCell(cell)
        print("here is the selected cell: " )
        // using tags to keep track of which sur
        //let defaults = NSUserDefaults.standardUserDefaults()
        if finishNavigationButton.tag == 1{
            //defaults.setObject(NSDate(), forKey: "weekday_timestamp")
        } else{
            //defaults.setObject(NSDate(), forKey: "weekend_timestamp")
        }
        
        let workdayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("activityStoryBoardID")
        
        let navigationController = UINavigationController(rootViewController: workdayViewController!)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
        
    }
    
    @IBAction func reloadImages() {
        
        self.collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self;
        collectionView.dataSource = self
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
        
        let name = NSString(format: "%d_%d.jpg",indexPath.row + 1,random)
        
        cell.imageView.image = UIImage(named: name.lowercaseString)
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
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)

    }
}
