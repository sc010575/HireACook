//
//  SACollectionViewVerticalScalingCell.h
//  SACollectionViewVerticalScalingCell
//
//  Created by 鈴木大貴 on 2015/01/23.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SACollectionViewVerticalScalingCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIView *containerView;
@property (assign, nonatomic) CGAffineTransform shadeTransform;
@property (assign, nonatomic) CGFloat shadeAlpha;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net4