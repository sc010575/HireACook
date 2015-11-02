//
//  DisplayRecordView.m
//  HireACook
//
//  Created by Suman Chatterjee on 12/08/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import "DisplayRecordView.h"
#import "AFNetworking.h"

@interface DisplayRecordView()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end


@implementation DisplayRecordView

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void) setup{
    
    [self.waitIndicator startAnimating];
    
}

- (void)createRecordViewWith:(NSString*) imageUrl andFirstNme:(NSString*) theFirstName andLastName:(NSString*) theLastName{
    
    __weak DisplayRecordView *weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"Response: %@", responseObject);
        _imageView.image = [UIImage imageWithData:responseObject];
        [weakSelf.waitIndicator stopAnimating];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
    self.name.text = [NSString stringWithFormat:@"%@ %@", theFirstName, theLastName];
}


@end
