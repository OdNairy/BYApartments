//
//  BYARemoteObject.h
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BYARemoteObject <NSObject>
@optional
+(NSArray*)allObject;
+(id)objectForId:(NSString*)objectId;
@end
