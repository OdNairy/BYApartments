//
//  BYAPriceFormatter.m
//  ByApartments
//
//  Created by odnairy on 11/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAPriceFormatter.h"

NSInteger normalizePriceValue(NSInteger value){
    if (value <= 20) {
        return value*50;
    }else {
        return (value-20)*100+20*50;
    }
}

@implementation BYAPriceFormatter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberStyle = NSNumberFormatterDecimalStyle;
        self.maximumFractionDigits = 0;
    }
    return self;
}

-(NSString *)stringFromNumber:(NSNumber *)number{
    return [super stringFromNumber:@(normalizePriceValue(number.integerValue))];
}


@end
