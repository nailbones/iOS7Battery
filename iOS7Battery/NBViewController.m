//
//  NBViewController.m
//  iOS7Battery
//
//  Created by nailbones on 4/24/14.
//  Copyright (c) 2014 nailbones. All rights reserved.
//

#import "NBViewController.h"
#import "NBPLUtil.h"
#import "NBBatteryTableView.h"

@interface NBViewController ()
{
    NBBatteryTableView *_bodyView;
}

@end

static int const kStatusBarHeight = 20;

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    bounds.size.height -= kStatusBarHeight;
    bounds.origin.y += kStatusBarHeight;
    
    _bodyView = [[NBBatteryTableView alloc] initWithFrame:bounds];
    [self.view addSubview:_bodyView];
    [self batteryData];
}

- (void)batteryData
{
    id batteryData = PL_BatteryData();
    [_bodyView reloadData:batteryData];
    [self performSelector:@selector(batteryData) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
