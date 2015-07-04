//
//  BYAApartmentsListViewController.m
//  ByApartments
//
//  Created by odnairy on 05/04/15.
//  Copyright (c) 2015 Roman Gardukevich. All rights reserved.
//

#import <Parse/Parse.h>
#import <PromiseKit.h>
#import <Parse+PromiseKit.h>
#import "UIImageView+WebCache.h"
#import <Masonry.h>

#import "BYAApartmentsListViewController.h"
#import "BYAApartmentCell.h"
#import "BYAApartmentController.h"
#import "BYASidebarController.h"
#import "Masonry.h"
#import "BYAApartment.h"
#import "BYAApartmentsModel.h"
#import "BYAGeobox.h"
#import "DateTools.h"

@interface BYAApartmentsListViewController ()<UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) BYAApartmentsModel* apartmentsModel;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

@property (nonatomic, strong) NSArray* apartments;

@property (nonatomic, assign) BOOL optionsScreenPresented;

@property (nonatomic, strong) BYASidebarController* sidebarController;
@property (nonatomic, strong) MASConstraint* sideConstraint;
@property (nonatomic, assign) BOOL failedPanTouch;

@property (nonatomic, strong) UITapGestureRecognizer* tapGesture;
@end

@implementation BYAApartmentsListViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    self.apartmentsModel = [BYAApartmentsModel sharedModel];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidPulled) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView addSubview:self.refreshControl];

    [self.refreshControl beginRefreshing];
    [self updateApartments].then(^(){
        [self.refreshControl endRefreshing];
    });
    
    [self configureSidebarController];
    UIPanGestureRecognizer* edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                                  action:@selector(panGesture:)];
    [self.navigationController.view addGestureRecognizer:edgePan];
    
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDidTapped:)];
    self.tapGesture.enabled = NO;
    [self.navigationController.view addGestureRecognizer:self.tapGesture];
}

-(void)configureSidebarController{
    self.sidebarController = [self.storyboard instantiateViewControllerWithIdentifier:@"Sidebar"];
    self.sidebarController.view.backgroundColor = [UIColor redColor];
    
    [self addChildViewController:self.sidebarController];
    [self.view addSubview:self.sidebarController.view];
    
    [self.sidebarController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@([self sideBarWidth]));
        make.height.equalTo(self.view);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).with.offset(-self.view.bounds.size.width);
    }];
}

-(CGFloat)sideBarWidth{
    return self.view.bounds.size.width*7/8;
}

#pragma mark - User Actions

-(IBAction)showOptionsButtonDidTapped:(id)showOptionsButton{
    if (!self.optionsScreenPresented) {
        [self presentOptionsScreen:YES];
    }else {
        [self hideOptionsScreen:YES];
    }
}


-(void)refreshControlDidPulled{
    [self updateApartments].finally(^(){
        [self.refreshControl endRefreshing];
    });
}

-(BYAGeobox*)currentGeobox{
    return [[BYAGeobox alloc] initWithDictionary:@{kBYAGeoboxSouthPointKey:@53.880413648385016,
                                                   kBYAGeoboxWestPointKey:@27.484445571899414,
                                                   kBYAGeoboxNorthPointKey:@53.90236604048426,
                                                   kBYAGeoboxEastPointKey:@27.544527053833008}];
}

-(PMKPromise*)updateApartments{
    return [self.apartmentsModel allObjectsInsideGeobox:[self currentGeobox]].then(^(NSArray* results){
        self.apartments = results;
        [self.tableView reloadData];
    });
}

-(IBAction)tapGestureDidTapped:(UITapGestureRecognizer*)tapGesture{
    [UIView animateWithDuration:2 animations:^{
        [self.sidebarController.view mas_updateConstraints:^(MASConstraintMaker *make) {
            [self.sidebarController.view layoutIfNeeded];
            [self.view layoutIfNeeded];
            make.left.equalTo(self.view.mas_left).with.offset(-[self sideBarWidth]);
            self.optionsScreenPresented = NO;;
        }];
    }];
}

-(IBAction)panGesture:(UIPanGestureRecognizer*)panGestureRecognizer{
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            CGPoint position = [panGestureRecognizer locationInView:panGestureRecognizer.view];
            if (position.x > 25 || self.optionsScreenPresented) {
                panGestureRecognizer.enabled = NO;
                panGestureRecognizer.enabled = YES;
                self.failedPanTouch = YES;
                return;
            }
            
            // continue to Changed state
        }
            
        case UIGestureRecognizerStateChanged:{
            CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
            [self.sidebarController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                CGFloat offset = (translation.x-[self sideBarWidth]) <= 0 ? (translation.x-[self sideBarWidth]) : 0;
                make.left.equalTo(self.view.mas_left).with.offset(offset);
            }];
        }
            
            break;
        case UIGestureRecognizerStateEnded:{
            CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
            
            CGFloat offset = -[self sideBarWidth];
            CGFloat sideFraction = translation.x / [self sideBarWidth];
            BOOL optionsAreClosed = YES;
            if (sideFraction >= .5) {
                offset = 0;
                optionsAreClosed = NO;
            }
            
            [UIView animateWithDuration:2 animations:^{
                [self.sidebarController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    [self.sidebarController.view layoutIfNeeded];
                    make.left.equalTo(self.view.mas_left).with.offset(offset);
                    self.optionsScreenPresented = !optionsAreClosed;
                }];
            }];
            self.failedPanTouch = NO;
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark - Setters and Getters
-(void)setOptionsScreenPresented:(BOOL)optionsScreenPresented{
    _optionsScreenPresented = optionsScreenPresented;
    self.tapGesture.enabled = optionsScreenPresented;
}

#pragma mark - Options Screen
const int optionsScreenPadding = 60;
-(void)presentOptionsScreen:(BOOL)animated{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:.3 animations:^{
        [self.sideConstraint uninstall];
        [self.sidebarController.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
        }];
        [self.sidebarController.view layoutIfNeeded];
        self.optionsScreenPresented = YES;
    }];
}

-(void)hideOptionsScreen:(BOOL)animated{
    [UIView animateWithDuration:.3 animations:^{
        [self.sidebarController.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(-self.view.bounds.size.width);
        }];
        [self.sidebarController.view layoutIfNeeded];
    } completion:^(BOOL finished) {

        self.optionsScreenPresented = NO;
    }];
}

#pragma mark - UITableViewDataSource Protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apartments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BYAApartmentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    BYAApartment* apartment = self.apartments[indexPath.row];

    cell.addressLabel.text = apartment.userAddress;
    cell.priceLabel.text = [apartment priceString];
    cell.ownerLabel.text = [apartment ownerString];
    cell.datetimeLabel.text = [apartment.apartmentAddedAt timeAgoSinceDate:[NSDate date] numericDates:YES numericTimes:NO];
    [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:apartment.photoUrl]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                           if (cell.backgroundImageView.image != image) {
                                           cell.backgroundImageView.image = image;
//                                           [cell.blurView updateAsynchronously:YES completion:NULL];
                                           
//                                           cell.blurView.underlyingView = cell.backgroundImageView;
//                                           }
//                                           cell.bluringImageView.image = image;
                                       }];
    return cell;
}

-(BOOL)shouldPerformSegueWithIdentifier:(nonnull NSString *)identifier sender:(nullable id)sender{
    if (self.failedPanTouch) {
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Apartment"]) {
        BYAApartmentController* apartmentController = segue.destinationViewController;
        apartmentController.apartment = self.apartments[self.tableView.indexPathForSelectedRow.row];
    }
}

@end
