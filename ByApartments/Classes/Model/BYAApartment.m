//
//  BYAApartment.m
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAApartment.h"
#import <Parse/PFObject+Subclass.h>

@implementation BYAApartment
@dynamic onlinerID, location, apartmentAddedAt, priceUSD, photoUrl, userAddress;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Apartment";
}



@end
