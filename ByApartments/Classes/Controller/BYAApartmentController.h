//
//  BYAApartmentController.h
//  ByApartments
//
//  Created by odnairy on 17/06/15.
//  Copyright © 2015 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYAApartment.h"

typedef NS_ENUM(NSInteger, BYAApartmentSection) {
    BYAApartmentSectionPhotos,
    BYAApartmentSectionPrice,
    BYAApartmentSectionAddress,
    BYAApartmentSectionDescription,
    BYAApartmentSectionOptions,
    
    BYAApartmentSectionCount
};


@interface BYAApartmentController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) BYAApartment* apartment;
@end
