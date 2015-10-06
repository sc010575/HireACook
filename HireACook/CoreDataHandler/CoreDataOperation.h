//
//  CoreDataOperation.h
//  HireACook
//
//  Created by Suman Chatterjee on 02/07/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSManagedObject+CoreDataHandler.h"
#import "NSManagedObjectContext+Helper.h"

@interface CoreDataOperation : NSOperation

- (instancetype)initWithData:(NSArray *)data withSharedStoreCoordinator:(NSPersistentStoreCoordinator *)psc ;

    
@end
