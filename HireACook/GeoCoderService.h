//
//  GeoCoderService.h
//  HireACook
//
//  Created by Suman Chatterjee on 22/06/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^SearchCompletionBlock)(CLLocationCoordinate2D results);

@interface GeoCoderService : NSObject

+ (void) performGeocodingForText:(NSString*) postCode
                completionBlock:(SearchCompletionBlock)completionBlock;


@end
