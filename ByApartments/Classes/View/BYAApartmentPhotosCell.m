//
//  BYAApartmentPhotosCell.m
//  ByApartments
//
//  Created by odnairy on 17/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAApartmentPhotosCell.h"

@implementation BYAApartmentPhotosCell
-(void)awakeFromNib{
    self.dateTimeLabel.layer.shadowOpacity = .6;
    self.dateTimeLabel.layer.shadowOffset = CGSizeZero;
    self.dateTimeLabel.layer.shadowRadius = 5;
    self.dateTimeLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.dateTimeLabel.layer.masksToBounds = NO;
}
@end
