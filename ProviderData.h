//
//  ProviderData.h
//  
//
//  Created by Suman Chatterjee on 10/07/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GeoPoints, Providermedia;

@interface ProviderData : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * peopleId;
@property (nonatomic, retain) NSString * postCode;
@property (nonatomic, retain) NSString * profilePicture;
@property (nonatomic, retain) NSString * rate;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) GeoPoints *geoPoints;
@property (nonatomic, retain) NSSet *imageMedia;
@end

@interface ProviderData (CoreDataGeneratedAccessors)

- (void)addImageMediaObject:(Providermedia *)value;
- (void)removeImageMediaObject:(Providermedia *)value;
- (void)addImageMedia:(NSSet *)values;
- (void)removeImageMedia:(NSSet *)values;

@end
