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

+(instancetype)sharedModel{
    static dispatch_once_t onceToken;
    static BYAApartmentsModel* model;
    dispatch_once(&onceToken, ^{
        model = [[BYAApartmentsModel alloc] init];
    });
    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(nonnull PMKPromise *)allObjects{
    return [self allObjectsInsideGeobox:nil];
}

-(nonnull PMKPromise *)allObjectsInsideGeobox:(nullable BYAGeobox *)geobox{
    return [PFCloud promiseFunction:@"apartmentsByGeobox"
                     withParameters:[geobox serializeObject]]
    .then(^(NSDictionary* functionCallResult){
        return functionCallResult[@"results"];
    });
}

-(nonnull PMKPromise *)objectForId:(nonnull NSString *)objectId{
    return nil;
}

@end


