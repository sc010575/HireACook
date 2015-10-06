//
//  ParseServiceLocator.m
//  HireACook
//
//  Created by Suman Chatterjee on 22/06/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import "ParseServiceLocator.h"

@implementation ParseServiceLocator

+ (void)setupParseWithOption:(NSDictionary *)launchOptions;
{
    //Adding Parse
    [Parse enableLocalDatastore];
    // Initialize Parse.
    [Parse setApplicationId:@"xjTJa6b3qDBd0EF669KL54MBJZ6S4tTXKPOFhdZ2"
                  clientKey:@"SKNC5CtmQoxVBDEJY8Ne9p0sEicKKiFR31aJOevs"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //    testObject[@"foo"] = @"bar";
    //    [testObject saveInBackground];
    
}

+ (void)queryWithGeoPoint:(CLLocationCoordinate2D) geoPoint callback:(ParseCompletionBlock) callback;
{
    int radiousInKM = 50;
    PFGeoPoint * postCodeGeoPoint = [[PFGeoPoint alloc]init];
    postCodeGeoPoint.latitude = geoPoint.latitude;
    postCodeGeoPoint.longitude = geoPoint.longitude;
    
    PFQuery *query = [PFQuery queryWithClassName:@"ServiceProviderMaster"];
    [query whereKey:@"GeoPoints" nearGeoPoint:postCodeGeoPoint withinKilometers:radiousInKM];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSLog(@"Successfully retrieved %lu count.", (unsigned long)objects.count);
            // Do something with the found objects
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *recordDetails = [query findObjects];
//                for (PFObject * individualRecord in recordDetails)
//                {
//                    NSLog(@"value: %@ ", individualRecord);
//
//                    //[self processIndividualRecord:individualRecord withContext:updateContext];
//                }
//                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(callback){
                        callback(recordDetails,error);
                    }
                });
            });

        } else {
            // Details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
