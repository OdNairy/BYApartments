//
//  BYAApartmentPhotosCell.h
//  ByApartments
//
//  Created by odnairy on 17/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYAApartmentPhotosCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView* placeholderImageView;
@property (weak, nonatomic) IBOutlet UIView *datetimeBackgroundView;

@end
