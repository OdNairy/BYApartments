//
//  BYAFilterModel.h
//  ByApartments
//
//  Created by odnairy on 11/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, BYAFilterOwnerType) {
    BYAFilterOwner,
    BYAFilterAgent,
    BYAFilterUnknown,
    BYAFilterOwnerTypeDefault = BYAFilterUnknown
};

@interface BYAFilterModel : NSObject
@property (nonatomic, assign) BYAFilterOwnerType owner;

@property (nonatomic, strong) NSNumber* minPrice;
@property (nonatomic, strong) NSNumber* maxPrice;


@end
