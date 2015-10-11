//
//  SACollectionViewVerticalScalingCell.h
//  SACollectionViewVerticalScalingCell
//
//  Created by 鈴木大貴 on 2015/01/23.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayRecordView.h"

@interface SACollectionViewVerticalScalingCell : UICollectionViewCell

@property (strong, nonatomic, readonly) DisplayRecordView *containerView;
@property (assign, nonatomic) CGAffineTransform shadeTransform;
@property (assign, nonatomic) CGFloat shadeAlpha;

- (void)createRecordViewWith:(NSString*) imageUrl andFirstNme:(NSString*) theFirstName andLastName:(NSString*) theLastName;

@end
