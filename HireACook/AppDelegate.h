//
//  AppDelegate.h
//  HireACook
//
//  Created by Suman Chatterjee on 15/05/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end

