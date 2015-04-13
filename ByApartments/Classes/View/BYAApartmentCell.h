//
//  BYAApartmentCell.h
//  ByApartments
//
//  Created by odnairy on 05/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYAApartmentCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView* backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel* addressLabel;
@property (nonatomic, weak) IBOutlet UIView* gradientView;
@property (nonatomic, weak) IBOutlet UILabel* priceLabel;

@property (nonatomic, weak) IBOutlet UILabel* ownerLabel;
@property (nonatomic, weak) IBOutlet UILabel* roomNumberLabel;

@end
