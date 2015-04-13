//
//  BYAApartmentCell.m
//  ByApartments
//
//  Created by odnairy on 05/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAApartmentCell.h"

@implementation BYAApartmentCell
-(void)awakeFromNib{

    UIColor *startColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    UIColor *endColor = [UIColor clearColor];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.startPoint = CGPointMake(0.5, 0.2);
    gradient.endPoint = CGPointMake(0.5, 1);
    gradient.colors = @[(id)[startColor CGColor], (id)[endColor CGColor]];

    [self.gradientView.layer addSublayer:gradient];
    self.gradientView.backgroundColor = [UIColor clearColor];
}
@end
