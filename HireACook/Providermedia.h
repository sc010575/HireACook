//
//  Providermedia.h
//  
//
//  Created by Suman Chatterjee on 06/07/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProviderData;

@interface Providermedia : NSManagedObject

@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) ProviderData *providerData;

@end
