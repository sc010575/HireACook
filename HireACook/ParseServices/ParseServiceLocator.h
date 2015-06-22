//
//  ParseServiceLocator.h
//  HireACook
//
//  Created by Suman Chatterjee on 22/06/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

typedef void(^ParseCompletionBlock)(NSArray *objects, NSError *error);


@interface ParseServiceLocator : NSObject

+ (void)setupParseWithOption:(NSDictionary *)launchOptions;
+ (void)queryWithGeoPoint:(CLLocationCoordinate2D) geoPoint callback:(ParseCompletionBlock) callback;

@end
