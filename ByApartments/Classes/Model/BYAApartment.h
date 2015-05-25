//
//  BYAApartment.h
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BYAApartment : PFObject<PFSubclassing>
@property (nonatomic, assign) NSInteger onlinerID;
@property (nonatomic, strong) NSDate* apartmentAddedAt;
@property (nonatomic, strong) PFGeoPoint* location;
@property (nonatomic, strong) NSNumber* priceUSD;
@property (nonatomic, strong) NSString* userAddress;
@property (nonatomic, strong) NSString* photoUrl;

@end
