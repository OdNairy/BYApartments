//
//  BYAApartment.h
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

@import Foundation;
#import <Parse/Parse.h>
#import <PromiseKit.h>

@interface BYAApartment : PFObject<PFSubclassing>
@property (nonatomic, assign) NSInteger onlinerID;
@property (nonatomic, strong, nonnull) NSDate* apartmentAddedAt;
@property (nonatomic, strong, nonnull) PFGeoPoint* location;
@property (nonatomic, strong, nonnull) NSString* userAddress;
@property (nonatomic, strong, nonnull) NSString* photoUrl;
@property (nonatomic, strong, nonnull) NSNumber* priceUSD;
@property (nonatomic, strong, nonnull) NSURL* url;
@property (nonatomic, assign) BOOL owner;

@property (nonatomic, strong, nullable) NSArray<NSURL*>* photos;
@property (nonatomic, strong, nullable) NSString* dealDescription;
@property (nonatomic, strong, nullable) NSArray* phoneNumbers;
@property (nonatomic, strong, nullable) NSString* phoneComment;
@property (nonatomic, strong, nullable) NSString* authorName;


@property (nonatomic, assign, getter=isLoadingCurrentDetails) BOOL loadingCurrentDetails;
@property (nonatomic, assign, getter=isDetailsAreLoaded) BOOL detailsAreLoaded;

-(nullable NSString*)ownerString;
-(nullable NSString*)priceString;

-(nullable PMKPromise*)loadDetails;
@end
