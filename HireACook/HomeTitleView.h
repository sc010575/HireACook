//
//  HomeTitleView.h
//  HireACook
//
//  Created by Suman Chatterjee on 22/04/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTitleView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UIButton *closeButtom;
- (IBAction)closeAction:(id)sender;

@end
