//
//  BYARemoteObject.h
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "PromiseKit.h"
@import Foundation;

@protocol BYARemoteObject <NSObject>
@optional
-(nonnull PMKPromise *)allObjects;
-(nonnull PMKPromise *)objectForId:(nonnull NSString*)objectId;
@end

@class BYAGeobox;
@protocol BYAApartmentObject <NSObject, BYARemoteObject>

-(nonnull PMKPromise *)allObjectsInsideGeobox:(nullable BYAGeobox*)geobox;

@end