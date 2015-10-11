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
    
    @IBOutlet weak var registerButton: UIButton!
    
    lazy var coredataQueue: NSOperationQueue={
        var queue = NSOperationQueue()
        queue.name = "CoreDataQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
        }()
    
    var bDataFatched:Bool = false
    
    var progressHUD:ProgressHUD!
    var numberOfRecord:Int = 0
    private var kvoContext: UInt8 = 1
    
    
    @IBAction func performSearch(sender: AnyObject) {
        
        // Create and add the view to the screen.
        progressHUD = ProgressHUD(text: "Searching..")
        self.view.addSubview(progressHUD)
        
        GeoCoderService.performGeocodingForText(self.postcodTextField.text, completionBlock: { (location:CLLocationCoordinate2D) -> Void in
            if !CLLocationCoordinate2DIsValid(location)
            {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let alertView = UIAlertController(title: "Postcode error", message: "No match found", preferredStyle: .Alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(alertView, animated: true, completion: nil)
                    self.progressHUD.hide()
                    self.postcodTextField.text = ""

                })
                
            }else{
                
                print("location data  :\(location)")
                ParseServiceLocator.queryWithGeoPoint(location, callback: { (record:[AnyObject]!, error:NSError!) -> Void in
                    print("location data  :\(record)")
                    let standardUserdefault = NSUserDefaults.standardUserDefaults()
                    standardUserdefault.setInteger(record.count, forKey: "NumberOfRecords")
                    standardUserdefault.synchronize()
                    
                    let storeCoordinator  = (UIApplication.sharedApplication().delegate as! AppDelegate).persistentStoreCoordinator
                    
                    let coreDataOperation = CoreDataOperation(data: record, withSharedStoreCoordinator: storeCoordinator)
                    self.coredataQueue.addOperation(coreDataOperation)
                })
            }
        })
        
        //Add observer when the operation queue finish
        self.coredataQueue.addObserver(self, forKeyPath: "operationCount", options: NSKeyValueObservingOptions.New, context: &self.kvoContext)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
        super.viewWillAppear(animated)
        self.postcodTextField.text = ""
        self.postcodTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "goRegistration"{
            return true
        }
        
        if identifier == "showrecord" && self.bDataFatched{
            return true
        }else{
            return false
        }
        
    }
    
    
    // MARK: -KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &kvoContext {
            print("Change at keyPath = \(keyPath) for \(object)")
            if self.coredataQueue.operationCount == 0{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.bDataFatched = true
                    self.progressHUD.hide()
                    self.performSegueWithIdentifier("showrecord", sender: self)
                })
            }
            
        }
    }
}