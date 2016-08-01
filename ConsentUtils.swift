//
//  ConsentUtils.swift
//  workaday
//
//  Created by Adam Preston on 8/1/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit


func loadHTMLContent(fileName: String)->String{
    var fileContents: String? = nil
    
    let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "html")
    if path == nil {
        print("OOPPPPS")
    }else{
        print(path)
        
        do {
            fileContents = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        } catch _ as NSError {
            print("OOPPPPS")
        }
        // print(fileContents)
    }
    
    return fileContents!
    
    
}

