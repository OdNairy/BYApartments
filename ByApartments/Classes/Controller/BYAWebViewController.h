//
//  BYAWebViewController.h
//  ByApartments
//
//  Created by odnairy on 17/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BYAWebViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIWebView* webView;
@property (nonatomic, strong) PFObject* apartment;
@end
