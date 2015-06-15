//
//  BYAGeobox.h
//  ByApartments
//
//  Created by odnairy on 15/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

@import Foundation;
@import CoreLocation;
#import "BYASerialization.h"

@interface BYAGeobox : NSObject<BYASerializableObject>
@property (nonatomic, assign) CLLocationCoordinate2D northWestPoint;
@property (nonatomic, assign) CLLocationCoordinate2D southEastPoint;


// format: {s:value, w:value, n:value, e:value}
-(instancetype)initWithDictionary:(NSDictionary*)geoboxDictionary NS_DESIGNATED_INITIALIZER;
@end



extern NSString* const kBYAGeoboxNorthPointKey;
extern NSString* const kBYAGeoboxEastPointKey;
extern NSString* const kBYAGeoboxWestPointKey;
extern NSString* const kBYAGeoboxSouthPointKey;