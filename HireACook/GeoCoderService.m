//
//  GeoCoderService.m
//  HireACook
//
//  Created by Suman Chatterjee on 22/06/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import "GeoCoderService.h"
#import <MapKit/MapKit.h>


@implementation GeoCoderService

+ (void) performGeocodingForText:(NSString*) postCode
                completionBlock:(SearchCompletionBlock)completionBlock
{


//Well it was not a gridref then perform geo coding
CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:postCode completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            if(completionBlock)
            {
                completionBlock(coordinate);
            }
        }
    }];

}

@end
