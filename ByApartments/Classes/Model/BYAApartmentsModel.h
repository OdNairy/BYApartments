//
//  BYAApartmentsModel.h
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

@import Foundation;
#import "BYARemoteObject.h"

@interface BYAApartmentsModel : NSObject<BYAApartmentObject>

+(instancetype)sharedModel;
-(instancetype)init NS_DESIGNATED_INITIALIZER;

@end
