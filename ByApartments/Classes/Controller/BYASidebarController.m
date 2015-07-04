//
//  BYASidebarController.m
//  ByApartments
//
//  Created by odnairy on 22/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYASidebarController.h"
#import <TTRangeSlider.h>
#import "Masonry.h"
#import "BYAPriceFormatter.h"

@interface BYASidebarController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *ownerSegmentControl;
@property (nonatomic, strong) TTRangeSlider* priceRangeSlider;

@end
@implementation BYASidebarController

-(void)awakeFromNib{
    self.priceRangeSlider = [[TTRangeSlider alloc] init];
    self.priceRangeSlider.numberFormatterOverride = [[BYAPriceFormatter alloc] init];
    [self.view addSubview:self.priceRangeSlider];

//    [self.priceRangeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.ownerSegmentControl);
//        make.top.equalTo(self.ownerSegmentControl.mas_bottom).with.offset(20);
//        make.height.equalTo(@44);
//    }];

    self.priceRangeSlider.minValue = 1;
    self.priceRangeSlider.maxValue = 40;
    self.priceRangeSlider.selectedMinimum = self.priceRangeSlider.minValue;
    self.priceRangeSlider.selectedMaximum = self.priceRangeSlider.maxValue;

}

@end
