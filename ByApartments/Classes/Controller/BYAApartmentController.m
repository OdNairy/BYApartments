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

@implementation BYAApartmentController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDataSource Protocol

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BYAApartmentSectionCount;
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
        default:
            break;
    }
    return cell;
}

#pragma -
- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath{
    return @[@"PhotosCell",@"PriceCell",@"OptionsCell",@"DescriptionCell",@"AddressCell"][indexPath.row];
}

-(void)configurePhotosCell:(UITableViewCell*)cell_{
    BYAApartmentPhotosCell* cell = (BYAApartmentPhotosCell*)cell_;
    [cell.placeholderImageView sd_setImageWithURL:[NSURL URLWithString:self.apartment.photoUrl]];
    
}
-(void)configurePriceCell:(UITableViewCell*)cell_{
    BYAApartmentPriceCell* cell = (BYAApartmentPriceCell*)cell_;
    cell.primaryPriceLabel.text = self.apartment.priceString;
    cell.secondaryPriceLabel.text = [self.apartment[@"priceBYR"] stringValue];
    
    cell.primaryPriceLabel.font = [UIFont boldSystemFontOfSize:24];
    cell.secondaryPriceLabel.font = [UIFont systemFontOfSize:18];
}

@end
