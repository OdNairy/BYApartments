//
//  BYAApartmentController.m
//  ByApartments
//
//  Created by odnairy on 17/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAApartmentController.h"
#import <UIImageView+WebCache.h>

#import "BYAApartmentPhotosCell.h"
#import "BYAApartmentPriceCell.h"
#import "BYAApartmentDescriptionCell.h"
#import "BYAApartmentAddressCell.h"
#import "DateTools.h"


@interface BYAApartmentController ()
@property (nonatomic, assign) BOOL viewIsAppearing;
@end

@implementation BYAApartmentController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.apartment.loadDetails.then(^(BYAApartment* apartment){
        if (!self.viewIsAppearing) {
            [self.tableView reloadData];
        }
        [self.tableView reloadData];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewIsAppearing = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.viewIsAppearing = NO;
}

#pragma mark - User Formatters
-(NSNumberFormatter*)usdPriceFormatter{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.maximumFractionDigits = 0;
    formatter.currencyCode = @"USD";
    return formatter;
}

-(NSNumberFormatter*)byrPriceFormatter{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.maximumFractionDigits = 0;
    formatter.currencyCode = @"BYR";
    return formatter;
}

#pragma mark - UITableViewDataSource Protocol

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.apartment isDetailsAreLoaded]) {
        return BYAApartmentSectionCount;
    }else {
        return 0;
    }
}

-(UITableViewCell*)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForIndexPath:indexPath]];
    switch (indexPath.row) {
        case BYAApartmentSectionPhotos:
            [self configurePhotosCell:cell];
            break;
        case BYAApartmentSectionPrice:
            [self configurePriceCell:cell];
            break;
        case BYAApartmentSectionDescription:
            [self configureDescriptionCell:cell];
            break;
        case BYAApartmentSectionAddress:
            [self configureAddressCell:cell];
            break;
        default:
            break;
    }
    return cell;
}

#pragma -
- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath{
    return @[@"PhotosCell",@"PriceCell",@"AddressCell", @"DescriptionCell", @"OptionsCell"][indexPath.row];
}

-(void)configurePhotosCell:(UITableViewCell*)cell_{
    BYAApartmentPhotosCell* cell = (BYAApartmentPhotosCell*)cell_;
    [cell.placeholderImageView sd_setImageWithURL:[NSURL URLWithString:self.apartment.photoUrl]];
    cell.dateTimeLabel.text = [self.apartment.apartmentAddedAt timeAgoSinceNow];
}

-(void)configurePriceCell:(UITableViewCell*)cell_{
    BYAApartmentPriceCell* cell = (BYAApartmentPriceCell*)cell_;
    cell.primaryPriceLabel.text = [self.usdPriceFormatter stringFromNumber:self.apartment.priceUSD];
    cell.secondaryPriceLabel.text = [self.byrPriceFormatter stringFromNumber:self.apartment[@"priceBYR"]];
    
    cell.primaryPriceLabel.font = [UIFont boldSystemFontOfSize:22];
    cell.secondaryPriceLabel.font = [UIFont systemFontOfSize:18];
}
-(void)configureDescriptionCell:(UITableViewCell*)cell_{
    BYAApartmentDescriptionCell* cell = (BYAApartmentDescriptionCell*)cell_;
    cell.descriptionLabel.text = self.apartment.dealDescription;
}
-(void)configureAddressCell:(UITableViewCell*)cell_{
    BYAApartmentAddressCell* cell = (BYAApartmentAddressCell*)cell_;
    cell.addressLabel.text = self.apartment.userAddress;
}

@end
