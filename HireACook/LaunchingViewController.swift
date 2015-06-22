//
//  LaunchingViewController.swift
//  HireACook
//
//  Created by Suman Chatterjee on 22/06/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

import UIKit

class LaunchingViewController: UIViewController {
    
    @IBOutlet weak var postcodTextField: UITextField!
    
    var bDataFatched:Bool = false
    
    @IBAction func performSearch(sender: AnyObject) {
        
        // Create and add the view to the screen.
        let progressHUD = ProgressHUD(text: "Searching..")
        self.view.addSubview(progressHUD)
        
        GeoCoderService.performGeocodingForText(self.postcodTextField.text, completionBlock: { (location:CLLocationCoordinate2D) -> Void in
            println("location data  :\(location)")
            ParseServiceLocator.queryWithGeoPoint(location, callback: { (record:[AnyObject]!, error:NSError!) -> Void in
                println("location data  :\(record)")
                self.bDataFatched = true
                self.performSegueWithIdentifier("showrecord", sender: self)
                
        })
            
            
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if self.bDataFatched{
            return true
        }else{
            return false
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showrecord"{
            
        }
    }
    
}
