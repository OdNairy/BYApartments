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

@interface BYAApartmentsListViewController ()<UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

@property (nonatomic, strong) NSArray* apartments;
@end

@implementation BYAApartmentsListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    // https://r.onliner.by/ak/?bounds[lb][lat]=[lb][long]=&bounds[rt][lat]=&bounds[rt][long]=&page=1&order=created_at:desc



    self.tableView.rowHeight = 180;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidPulled) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView addSubview:self.refreshControl];

    [self.refreshControl beginRefreshing];
    [self updateApartments].then(^(){
        [self.refreshControl endRefreshing];
    });
}

#pragma mark - Update UI

-(void)refreshControlDidPulled{
    [self updateApartments].finally(^(){
        [self.refreshControl endRefreshing];
    });
}

-(PMKPromise*)updateApartments{
    NSDictionary* geoBoxParams = @{@"s":@53.880413648385016,
                                   @"w":@27.484445571899414,
                                   @"n":@53.90236604048426,
                                   @"e":@27.544527053833008};
    return [PFCloud promiseFunction:@"apartmentsByGeobox" withParameters:geoBoxParams].then(^(NSDictionary* responseDictionary){
        self.apartments = responseDictionary[@"results"];
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource Protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apartments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BYAApartmentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject* apartment = self.apartments[indexPath.row];

    cell.addressLabel.text = apartment[@"userAddress"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ $",apartment[@"priceUSD"]];
    cell.ownerLabel.text = [apartment[@"owner"] boolValue] ? @"С" : @"А";
    [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:apartment[@"photoUrl"]]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           cell.backgroundImageView.image = image;
                                       }];
    return cell;
}

@end
