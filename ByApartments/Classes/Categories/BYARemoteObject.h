//
//  BYARemoteObject.h
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

@import Foundation;

@protocol BYARemoteObject <NSObject>
@optional
+(nullable NSArray *)allObjects;
+(nullable id)objectForId:(nonnull NSString*)objectId;
@end

@class BYAGeobox;
@protocol BYAApartmentObject <NSObject, BYARemoteObject>

+(nonnull NSArray*)allObjectsInsideGeobox:(nullable BYAGeobox*)geobox;

@end