//
//  SACollectionViewVerticalScalingCell.m
//  SACollectionViewVerticalScalingCell
//
//  Created by 鈴木大貴 on 2015/01/23.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

#import "SACollectionViewVerticalScalingCell.h"
#import "UIView+QuickNibs.h"
#import "DisplayRecordView.h"

@interface SACollectionViewVerticalScalingCell ()

@property (strong, nonatomic, readwrite) DisplayRecordView *containerView;
@property (strong, nonatomic) UIView *shadeView;

@end

@implementation SACollectionViewVerticalScalingCell

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - SACollectionViewVerticalScalingCell Override Methods
- (void)prepareForReuse {
    [super prepareForReuse];
    [self.containerView removeFromSuperview];
    [self.shadeView removeFromSuperview];
    [self initialize];
}

#pragma mark - SACollectionViewVerticalScalingCell Private Methods
- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    self.containerView = [DisplayRecordView loadFromNib]; // [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.containerView];
    self.shadeView = [[UIView alloc] initWithFrame:self.bounds];
    self.shadeView.backgroundColor = [UIColor blackColor];
    self.shadeView.alpha = 0.0f;
    [self addSubview:self.shadeView];
}

#pragma mark - SACollectionViewVerticalScalingCell Public Methods
- (void)setShadeTransform:(CGAffineTransform)shadeTransform {
    self.shadeView.transform = shadeTransform;
}

- (void)setShadeAlpha:(CGFloat)shadeAlpha {
    self.shadeView.alpha = shadeAlpha;
}

- (void)createRecordViewWith:(NSString*) imageUrl andFirstNme:(NSString*) theFirstName andLastName:(NSString*) theLastName{
    
    [self.containerView createRecordViewWith:imageUrl andFirstNme:theFirstName andLastName:theLastName];
}


@end
