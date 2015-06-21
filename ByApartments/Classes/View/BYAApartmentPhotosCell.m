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
    self.datetimeBackgroundView.layer.shadowOpacity = 0.99;
    self.datetimeBackgroundView.layer.masksToBounds = NO;
    self.datetimeBackgroundView.layer.shadowRadius = 3;
    self.datetimeBackgroundView.layer.shadowOffset = CGSizeZero;
    self.datetimeBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.datetimeBackgroundView.layer.cornerRadius = 3;
    
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
//    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.datet byRoundingCorners:<#(UIRectCorner)#> cornerRadii:<#(CGSize)#>];
//    self.datetimeBackgroundView.layer.mask
    
}

@end
