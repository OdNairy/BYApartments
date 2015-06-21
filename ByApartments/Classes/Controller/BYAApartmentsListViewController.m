//
//  BYAApartmentsListViewController.m
//  ByApartments
//
//  Created by odnairy on 05/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <Parse/Parse.h>
#import <PromiseKit.h>
#import <Parse+PromiseKit.h>
#import "UIImageView+WebCache.h"

#import "BYAApartmentsListViewController.h"
#import "BYAApartmentCell.h"
#import "BYAApartmentController.h"
#import "BYASidebarController.h"
#import "Masonry.h"
#import "BYAApartment.h"
#import "BYAApartmentsModel.h"
#import "BYAGeobox.h"
#import "DateTools.h"

@interface BYAApartmentsListViewController ()<UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) BYAApartmentsModel* apartmentsModel;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

@property (nonatomic, strong) NSArray* apartments;

@property (nonatomic, assign) BOOL optionsScreenPresented;
@property (nonatomic, strong) BYASidebarController* sidebarController;
@end

@implementation BYAApartmentsListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    // https://r.onliner.by/ak/?bounds[lb][lat]=[lb][long]=&bounds[rt][lat]=&bounds[rt][long]=&page=1&order=created_at:desc

    self.apartmentsModel = [BYAApartmentsModel sharedModel];

    self.tableView.rowHeight = 180;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidPulled) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView addSubview:self.refreshControl];

    [self.refreshControl beginRefreshing];
    [self updateApartments].then(^(){
        [self.refreshControl endRefreshing];
    });
}

#pragma mark - User Actions

-(IBAction)showOptionsButtonDidTapped:(id)showOptionsButton{
    if (!self.optionsScreenPresented) {
        [self presentOptionsScreen:YES];
    }else {
        [self hideOptionsScreen:YES];
    }
}


-(void)refreshControlDidPulled{
    [self updateApartments].finally(^(){
        [self.refreshControl endRefreshing];
    });
}

-(BYAGeobox*)currentGeobox{
    return [[BYAGeobox alloc] initWithDictionary:@{kBYAGeoboxSouthPointKey:@53.880413648385016,
                                                   kBYAGeoboxWestPointKey:@27.484445571899414,
                                                   kBYAGeoboxNorthPointKey:@53.90236604048426,
                                                   kBYAGeoboxEastPointKey:@27.544527053833008}];
}

-(PMKPromise*)updateApartments{
    return [self.apartmentsModel allObjectsInsideGeobox:[self currentGeobox]].then(^(NSArray* results){
        self.apartments = results;
        [self.tableView reloadData];
    });
}

#pragma mark - Options Screen
const int optionsScreenPadding = 60;
-(void)presentOptionsScreen:(BOOL)animated{
    self.sidebarController = [self.storyboard instantiateViewControllerWithIdentifier:@"Sidebar"];
    self.sidebarController.view.frame = CGRectMake(0, 0, self.sidebarController.view.bounds.size.width - optionsScreenPadding, self.sidebarController.view.bounds.size.height);
    [self addChildViewController:self.sidebarController];

    self.sidebarController.view.frame = CGRectOffset(self.sidebarController.view.frame, -self.sidebarController.view.bounds.size.width, 0);
    [self.view addSubview:self.sidebarController.view];

    [self.view layoutIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        self.sidebarController.view.frame = CGRectOffset(self.sidebarController.view.frame, self.sidebarController.view.bounds.size.width, 0);
        self.optionsScreenPresented = YES;
    }];
}

-(void)hideOptionsScreen:(BOOL)animated{
    [UIView animateWithDuration:.3 animations:^{
        self.sidebarController.view.frame = CGRectOffset(self.sidebarController.view.frame, -self.sidebarController.view.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [self.sidebarController.view removeFromSuperview];
        [self.sidebarController removeFromParentViewController];
        self.sidebarController = nil;

        self.optionsScreenPresented = NO;
    }];
}

#pragma mark - UITableViewDataSource Protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apartments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BYAApartmentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    BYAApartment* apartment = self.apartments[indexPath.row];

    cell.addressLabel.text = apartment.userAddress;
    cell.priceLabel.text = [apartment priceString];
    cell.ownerLabel.text = [apartment ownerString];
    cell.datetimeLabel.text = [apartment.apartmentAddedAt timeAgoSinceDate:[NSDate date] numericDates:YES numericTimes:NO];
    [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:apartment.photoUrl]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                           if (cell.backgroundImageView.image != image) {
                                           cell.backgroundImageView.image = image;
//                                           [cell.blurView updateAsynchronously:YES completion:NULL];
                                           
//                                           cell.blurView.underlyingView = cell.backgroundImageView;
//                                           }
//                                           cell.bluringImageView.image = image;
                                       }];
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Apartment"]) {
        BYAApartmentController* apartmentController = segue.destinationViewController;
        apartmentController.apartment = self.apartments[self.tableView.indexPathForSelectedRow.row];
    }
}

@end
