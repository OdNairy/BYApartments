//
//  BYAApartmentsModel.m
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAApartmentsModel.h"
#import "BYAGeobox.h"
#import "PFCloud.h"
#import "Parse+PromiseKit.h"


@implementation BYAApartmentsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(nullable NSArray *)allObjects{
    return [self allObjectsInsideGeobox:nil];
}

+(nonnull NSArray *)allObjectsInsideGeobox:(nullable BYAGeobox *)geobox{
    NSDictionary* functionCallResult = [PFCloud callFunction:@"apartmentsByGeobox" withParameters:[geobox serializeObject]];
    return functionCallResult[@"results"];
}

+(nullable id)objectForId:(nonnull NSString *)objectId{
    return nil;
}

@end


