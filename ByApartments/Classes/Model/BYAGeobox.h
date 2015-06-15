//
//  BYAGeobox.h
//  ByApartments
//
//  Created by odnairy on 15/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface BYAGeobox : NSObject
@property (nonatomic, assign) CLLocationCoordinate2D northWestPoint;
@property (nonatomic, assign) CLLocationCoordinate2D southEastPoint;


// format: {s:value, w:value, n:value, e:value}
-(instancetype)initWithDictionary:(NSDictionary*)geoboxDictionary;
@end



extern NSString* const kBYAGeoboxNorthPointKey;
extern NSString* const kBYAGeoboxEastPointKey;
extern NSString* const kBYAGeoboxWestPointKey;
extern NSString* const kBYAGeoboxSouthPointKey;