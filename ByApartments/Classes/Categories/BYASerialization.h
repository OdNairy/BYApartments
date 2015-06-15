//
//  BYASerializableObject.h
//  ByApartments
//
//  Created by odnairy on 15/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BYASerializableObject <NSObject>
-(id __nullable)serializeObject;
@end


@protocol BYADeserializableObject <NSObject>
-(id __nullable)deserializeObject;
@end

@protocol BYAConvertableObject <BYASerializableObject, BYADeserializableObject>

@end