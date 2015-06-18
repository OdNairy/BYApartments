//
//  BYAApartment.m
//  ByApartments
//
//  Created by odnairy on 25/05/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAApartment.h"
#import <Parse/PFObject+Subclass.h>
#import "TFHpple.h"
#import <RegExCategories.h>

@interface BYAApartment (){
    TFHpple* _detailsDocument;
}
@end

@implementation BYAApartment
@dynamic onlinerID, location, apartmentAddedAt, priceUSD, photoUrl, userAddress, url, owner;
@synthesize photos=_photos, dealDescription=_dealDescription, phoneNumbers=_phoneNumbers, authorName=_authorName, loadingCurrentDetails=_loadingCurrentDetails, phoneComment=_phoneComment,detailsAreLoaded=_detailsAreLoaded;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Apartment";
}

-(NSURL *)url{
    return [NSURL URLWithString:self[@"url"]];
}

-(NSURLRequest*)urlRequest{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:self.url];
    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B410 Safari/600.1.4" forHTTPHeaderField:@"User-Agent"];
    return [request copy];
}

-(NSString *)ownerString{
    return self.owner ? NSLocalizedString(@"Owner", @"") : NSLocalizedString(@"Agent", @"");
}

-(NSString*)priceString{
    return [NSString stringWithFormat:@"%@ $",self.priceUSD.stringValue];
}


-(nullable PMKPromise *)loadDetails{
    if ([self isLoadingCurrentDetails]) {
        return nil;
    }
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        self.loadingCurrentDetails = YES;
        
        
        [NSURLConnection sendAsynchronousRequest:[self urlRequest]
                                           queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * __nullable response, NSData * __nullable data, NSError * __nullable connectionError) {
                                               self.loadingCurrentDetails = NO;
                                               if (!connectionError) {
                                                   fulfill(data);
                                               }else {
                                                   reject(connectionError);
                                               }
                                               
                                           }];
    }]
    .then(^(NSData* detailsHTMLData){
        _detailsDocument = [[TFHpple alloc] initWithHTMLData:detailsHTMLData];
        return _detailsDocument;
    })
    .then(^(TFHpple* detailsDocument){
        return [self parseDetails:detailsDocument];
    });
}


#pragma mark - Parsing Object
-(instancetype)parseDetails:(TFHpple*)detailsDocument{
    [self parsePhotos:detailsDocument];
    [self parseDescription:detailsDocument];
    [self parsePhoneNumber:detailsDocument];
    [self parsePhoneComment:detailsDocument];
    [self parseAuthorName:detailsDocument];
    self.detailsAreLoaded = YES;
    
    return self;
}

-(instancetype)parsePhotos:(TFHpple*)detailsDocument{
    NSMutableArray<NSURL*>* photos = [NSMutableArray array];
    
    NSArray* photosRaw = [detailsDocument searchWithXPathQuery:@"//div[@class='fotorama']/div"];
    for (TFHppleElement* element in photosRaw) {
        NSString* backgroundImageStyle = element.attributes[@"style"];
        
        RxMatch* match = [backgroundImageStyle firstMatchWithDetails:RX(@"url\\((.*).")];
        RxMatchGroup* lastGroup = match.groups.lastObject;
        if (lastGroup.value && [NSURL URLWithString:lastGroup.value]) {
            [photos addObject:[NSURL URLWithString:lastGroup.value]];
        }
    }
    self.photos = [photos copy];
    return self;
}

-(instancetype)parseDescription:(TFHpple*)detailsDocument{
    NSString* description = [[detailsDocument searchWithXPathQuery:@"//div[@class='apartment-info__line apartment-info__line_description']"].firstObject text];
    self.dealDescription = [description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return self;
}

-(instancetype)parsePhoneNumber:(TFHpple*)detailsDocument{
    NSArray* phonesRaw = [detailsDocument searchWithXPathQuery:@"//ul[@class='apartment-summary__list apartment-summary__list_phones']/li[@class='apartment-summary__item']/a[@class='apartment-summary__link']"];
    self.phoneNumbers = [phonesRaw valueForKey:@"text"];
    
    return self;
}

-(instancetype)parsePhoneComment:(TFHpple*)detailsDocument{
    NSString* phoneComment = [[[detailsDocument searchWithXPathQuery:@"//div[@class='apartment-summary__line apartment-summary__line_auxiliary']/div[@class='apartment-summary__sub-line']"] firstObject] text];
    self.phoneComment = [phoneComment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return self;
}

-(instancetype)parseAuthorName:(TFHpple*)detailsDocument{
    self.authorName = [[[detailsDocument searchWithXPathQuery:@"//div[@class='apartment-summary__line apartment-summary__line_auxiliary']/div[@class='apartment-summary__sub-line']/a"] firstObject] text];
    return self;
}

@end
