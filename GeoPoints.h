//
//  GeoPoints.h
//  
//
//  Created by Suman Chatterjee on 11/07/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProviderData;

@interface GeoPoints : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) ProviderData *providerData;

@end
