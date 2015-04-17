//
//  BYAWebViewController.m
//  ByApartments
//
//  Created by odnairy on 17/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import "BYAWebViewController.h"

@implementation BYAWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.apartment[@"url"]]]];
}
@end
