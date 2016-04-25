//
//  LaunchingViewController.swift
//  HireACook
//
//  Created by Suman Chatterjee on 22/06/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

import UIKit

@objc class LaunchingViewController: UIViewController {
    
    @IBOutlet weak var postcodTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var viewTopLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainBannerView: UIView!
    lazy var coredataQueue: NSOperationQueue={
        var queue = NSOperationQueue()
        queue.name = "CoreDataQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
        }()
    
    var bDataFatched:Bool = false
    
    var progressHUD:ProgressHUD!
    var numberOfRecord:Int = 0
    let transition = GeneralFadeAnimator()
    private var kvoContext: UInt8 = 1
    
    
    
    @IBAction func performSearch(sender: AnyObject) {
        
        if self.postcodTextField.text == "" {
            
            let alertView = UIAlertController(title: "Postcode error", message: "Please enter a Postcode", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
            return
        }
        
        if   !self.postcodTextField.text!.isAValidPostCode(){
            let alertView = UIAlertController(title: "Postcode error", message: "Please enter a valid Postcode", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
            self.postcodTextField.text = ""
            
            return
        }
        
        
        
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
        
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.mainBannerView.hidden = true
        //Add observer when the operation queue finish
        self.coredataQueue.addObserver(self, forKeyPath: "operationCount", options: NSKeyValueObservingOptions.New, context: &self.kvoContext)
        self.mainBannerView.slideInFromTop()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
        super.viewWillAppear(animated)
        self.bDataFatched = false
        self.mainBannerView.hidden = false
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showrecord"{
            
            let barViewControllers = segue.destinationViewController as! UITabBarController
            barViewControllers.transitioningDelegate = self
//            let navBar = barViewControllers.viewControllers![0] as! UINavigationController
//            if let homeViewController = navBar.topViewController as? HomeViewController{
//                
//                homeViewController.transitioningDelegate = self
//
//            }

            
            
        }
    }

}

extension LaunchingViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
        
    }
}
