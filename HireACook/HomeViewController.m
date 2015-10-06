//
//  FirstViewController.m
//  HireACook
//
//  Created by Suman Chatterjee on 15/05/2015.
//  Copyright (c) 2015 Suman Chatterjee. All rights reserved.
//

#import "HomeViewController.h"
#import "SACollectionViewVerticalScalingCell.h"
#import "SACollectionViewVerticalScalingFlowLayout.h"
#import "ProviderData.h"
#import "AppDelegate.h"
#import "NSManagedObjectContext+Helper.h"

static void *ProgressContext = &ProgressContext;

@interface HomeViewController ()

@property (strong, nonatomic) NSArray *items;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(strong, nonatomic)  NSNumber *numberOfRecordToShow;

@end

@implementation HomeViewController

static NSString *const kCellIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Use the main persistentStoreCoordinator
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [NSManagedObjectContext managedObjectContextWithStoreCoordinator:appDelegate.persistentStoreCoordinator];
    [self performAsyncFetch];
    
}

- (void)performAsyncFetch
{
    __weak HomeViewController *weakSelf = self;
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProviderData"];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"rate" ascending:YES]]];
    
    // Initialize Asynchronous Fetch Request
    NSAsynchronousFetchRequest *asynchronousFetchRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest completionBlock:^(NSAsynchronousFetchResult *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Dismiss Progress HUD
            
            // Process Asynchronous Fetch Result
            [weakSelf processAsynchronousFetchResult:result];
            
            // Remove Observer
            [result.progress removeObserver:weakSelf forKeyPath:@"completedUnitCount" context:ProgressContext];
        });
    }];
    
    
    // Execute Asynchronous Fetch Request
    [self.managedObjectContext performBlock:^{
        // Create Progress
        //  NSProgress *progress = [NSProgress progressWithTotalUnitCount:1];
        // Become Current
        //  [progress becomeCurrentWithPendingUnitCount:1];
        
        // Execute Asynchronous Fetch Request
        NSError *asynchronousFetchRequestError = nil;
        NSAsynchronousFetchResult *asynchronousFetchResult = (NSAsynchronousFetchResult *)[weakSelf.managedObjectContext executeRequest:asynchronousFetchRequest error:&asynchronousFetchRequestError];
        
        if (asynchronousFetchRequestError) {
            NSLog(@"Unable to execute asynchronous fetch result.");
            NSLog(@"%@, %@", asynchronousFetchRequestError, asynchronousFetchRequestError.localizedDescription);
        }
        
        // Add Observer
        [asynchronousFetchResult.progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:ProgressContext];
        
        // Resign Current
        //  [progress resignCurrent];
    }];

}

- (void)processAsynchronousFetchResult:(NSAsynchronousFetchResult *)asynchronousFetchResult {
    if (asynchronousFetchResult.finalResult) {
        // Update Items
        [self setItems:asynchronousFetchResult.finalResult];
        
        // Reload Table View
        //[self.tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden  = NO;
    [self.collectionView registerClass:[SACollectionViewVerticalScalingCell class] forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.dataSource = self;
    SACollectionViewVerticalScalingFlowLayout *layout = [[SACollectionViewVerticalScalingFlowLayout alloc] init];
    layout.scaleMode = SACollectionViewVerticalScalingFlowLayoutScaleModeHard;
    layout.alphaMode = SACollectionViewVerticalScalingFlowLayoutScaleModeEasy;
    self.collectionView.collectionViewLayout = layout;
    self.numberOfRecordToShow = @([[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfRecords"]);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   // return 30;
    
    return [self.numberOfRecordToShow integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SACollectionViewVerticalScalingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    NSInteger number = indexPath.row % 7 + 1;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@", @(number)]];
    UILabel *mylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    mylabel.text = @"Suman's image";
    mylabel.textColor = [UIColor whiteColor];
    [cell.containerView addSubview:mylabel ];
    [cell.containerView addSubview:imageView];
    [cell.containerView bringSubviewToFront:mylabel];
    return cell;
}



@end
