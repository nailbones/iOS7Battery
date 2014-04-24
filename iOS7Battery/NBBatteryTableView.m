//
//  NBBatteryTableView.m
//  iOS7Battery
//
//  Created by nailbones on 4/24/14.
//  Copyright (c) 2014 nailbones. All rights reserved.
//

#import "NBBatteryTableView.h"
#import "NBBatteryTableViewCell.h"

@interface NBBatteryTableView()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_batteryTableView;
    id _batteryData;
    NSMutableArray *_keys;
    NSDateFormatter *_dateFormatter;
}

@end

static NSString *const kBatteryTableCellIdentifier = @"theseAreAlwaysReallyBoringStringsSoHereIsSomethingInteresting";
static int const kUpdateTimeSection = 0;

@implementation NBBatteryTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect tableFrame = frame;
        tableFrame.origin.y = 0;
        _batteryTableView = [[UITableView alloc] initWithFrame:tableFrame];
        _batteryTableView.delegate = self;
        _batteryTableView.dataSource = self;
        _batteryTableView.backgroundColor = [UIColor blackColor];
        [self addSubview:_batteryTableView];
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeZone = [NSTimeZone localTimeZone];
        _dateFormatter.dateFormat = @"HH:mm:ss";
    }
    return self;
}

- (void)reloadData:(id)data
{
    _batteryData = data;
    _keys = [NSMutableArray arrayWithArray:[_batteryData performSelector:@selector(keys)]];
    [_batteryTableView reloadData];
}


#pragma mark - UITableViewSomethingDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == kUpdateTimeSection ? 1 : _keys.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBBatteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBatteryTableCellIdentifier];
    
    if (!cell)
    {
        cell = [[NBBatteryTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kBatteryTableCellIdentifier];
    }
    
    if (indexPath.section == kUpdateTimeSection)
    {
        cell.textLabel.text = @"Updated:";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_dateFormatter stringFromDate:[NSDate date]]];
    }
    else
    {
        NSString *key = [NSString stringWithFormat:@"%@",[_keys objectAtIndex:indexPath.row]];
        cell.textLabel.text = key;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_batteryData objectForKey:key]];
    }
    
    return cell;
}

@end