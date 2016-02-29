//
//  CoreLocationService.swift
//  HireACook
//
//  Created by Suman Chatterjee on 22/11/2015.
//  Copyright © 2015 Suman Chatterjee. All rights reserved.
//

import UIKit

let WE_GOT_LOCATION = "wegotlocation"

class CoreLocationService: NSObject , CLLocationManagerDelegate {
    
    class var sharedInstance: CoreLocationService {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CoreLocationService? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = CoreLocationService()
        }
        return Static.instance!
    }
    
    
    var locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"

    
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager = CLLocationManager()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 200
            self.locationManager.delegate = self
        }
    }
    
    func startTracking() {
        
        print("Start Location Updates")
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Update Location Error : \(error.description)")
        self.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as! CLLocation
            self.currentLocation = locationObj
            NSNotificationCenter.defaultCenter().postNotificationName(WE_GOT_LOCATION, object: nil, userInfo:nil)
        }
    }
    
    
}
