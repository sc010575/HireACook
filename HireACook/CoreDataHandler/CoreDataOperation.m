//
//  CoreDataOperation.m
//  HireACook
//
//  Created by Suman Chatterjee on 02/07/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import "CoreDataOperation.h"
#import "ProviderData.h"
#import "GeoPoints.h"

@interface CoreDataOperation()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *sharedPSC;
@property (nonatomic, strong) NSArray *dataRecords;

@end


@implementation CoreDataOperation


- (instancetype)initWithData:(NSArray *)data withSharedStoreCoordinator:(NSPersistentStoreCoordinator *)psc {
    
    self = [super init];
    if (self) {
        
        // keep the shared psc for creating context later in main
        _sharedPSC = psc;
        _dataRecords = data;
    }
    return self;
}


//main
// The main function for this NSOperation, to start the parsing.
- (void)main {
    
    // Creating context in main function here make sure the context is tied to current thread.
    self.managedObjectContext = [NSManagedObjectContext managedObjectContextWithStoreCoordinator:self.sharedPSC];
    [self saveRecordWithContext];
}




- (void)saveRecordWithContext
{
    if(self.isCancelled) {
        NSLog(@"Thread cancled " );
        return;
    }
    
    //delete old record
    [self.managedObjectContext deleteAllFromEntity:@"ProviderData"];
    [self.managedObjectContext deleteAllFromEntity:@"GeoPoints"];
    [self.managedObjectContext deleteAllFromEntity:@"Providermedia"];
    
    
    [self.managedObjectContext updateOnBackgroundThread:^(NSManagedObjectContext *updateContext) {
        for (PFObject * individualRecord in self.dataRecords)
        {
            [self processIndividualRecord:individualRecord withContext:updateContext];
        }
        
    } completion:^{
        //complete
    }];
    
}

-(void) processIndividualRecord:(PFObject*)record withContext:(NSManagedObjectContext*) context
{
    ProviderData *data = [ProviderData createInContext:context];
    PFFile *imageFile = record[@"ProfilePicture"];
    if(imageFile){
        data.profilePicture = imageFile.url;
    }
    data.firstName = record[@"FirstName"];
    data.lastName  = record[@"LastName"];
    data.peopleId  = record[@"PeopleId"];
    
    //Add Coordinate
    PFGeoPoint * cordDict = record[@"GeoPoints"];
    GeoPoints * geoPoints = [GeoPoints createInContext:context];
    geoPoints.latitude = @(cordDict.latitude);
    geoPoints.longitude = @(cordDict.longitude);
    
    data.geoPoints = geoPoints;
    
    
}
@end
