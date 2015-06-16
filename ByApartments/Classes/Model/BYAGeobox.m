//
//  BYAGeobox.m
//  ByApartments
//
//  Created by odnairy on 15/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAGeobox.h"

NSString* const kBYAGeoboxNorthPointKey =   @"n";
NSString* const kBYAGeoboxEastPointKey =    @"e";
NSString* const kBYAGeoboxWestPointKey =    @"w";
NSString* const kBYAGeoboxSouthPointKey =   @"s";

@implementation BYAGeobox

- (instancetype)init
{
    return [self initWithDictionary:nil];
}

-(instancetype)initWithDictionary:(NSDictionary*)geoboxDictionary{
    self = [super init];
    if (self) {
        if (geoboxDictionary) {
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
        
    }
    return self;
}

#pragma mark - BYASerializableObject
-(id __nullable)serializeObject{
    NSMutableDictionary* serializedObject = [NSMutableDictionary dictionary];
    serializedObject[kBYAGeoboxNorthPointKey] = @(self.northWestPoint.latitude);
    serializedObject[kBYAGeoboxWestPointKey] = @(self.northWestPoint.longitude);
    serializedObject[kBYAGeoboxSouthPointKey] = @(self.southEastPoint.latitude);
    serializedObject[kBYAGeoboxEastPointKey] = @(self.southEastPoint.longitude);
    return serializedObject;
}

@end
