//
//  FirstViewController.m
//  HireACook
//
//  Created by Suman Chatterjee on 15/05/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import "FirstViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
