//
//  BYAGeobox.m
//  ByApartments
//
//  Created by odnairy on 15/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAGeobox.h"

NSString* const kBYAGeoboxNorthPointKey =   @"kBYAGeoboxNorthPointKey";
NSString* const kBYAGeoboxEastPointKey =    @"kBYAGeoboxEastPointKey";
NSString* const kBYAGeoboxWestPointKey =    @"kBYAGeoboxWestPointKey";
NSString* const kBYAGeoboxSouthPointKey =   @"kBYAGeoboxSouthPointKey";

@implementation BYAGeobox

-(instancetype)initWithDictionary:(NSDictionary*)geoboxDictionary{
    self = [super init];
    if (self) {
        NSNumber* northPoint = geoboxDictionary[kBYAGeoboxNorthPointKey];
        NSNumber* westPoint = geoboxDictionary[kBYAGeoboxWestPointKey];
        
        CLLocationCoordinate2D northWestPoint;
        northWestPoint.latitude = northPoint.doubleValue;
        northWestPoint.longitude = westPoint.doubleValue;
        self.northWestPoint = northWestPoint;
        
        NSNumber* southPoint = geoboxDictionary[kBYAGeoboxSouthPointKey];
        NSNumber* eastPoint = geoboxDictionary[kBYAGeoboxEastPointKey];
        
        CLLocationCoordinate2D southEastPoint;
        southEastPoint.latitude = southPoint.doubleValue;
        southEastPoint.longitude = eastPoint.doubleValue;
        self.southEastPoint = southEastPoint;
        
    }
    return self;
}
@end
