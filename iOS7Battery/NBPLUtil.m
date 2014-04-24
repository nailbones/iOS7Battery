//
//  NBPLUtil.m
//  iOS7Battery
//
//  Created by nailbones on 4/24/14.
//  Copyright (c) 2014 nailbones. All rights reserved.
//
// !!WARNING!! THIS CLASS USES PRIVATE FRAMEWORKS
// THIS IS ONLY FOR DEVELOPMENT PURPOSES
// USE AT YOUR OWN RISK

#import "NBPLUtil.h"

//load the framework
//if this step is not done, app will fail
void PL_LoadFramework(void)
{
    NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/PowerlogLoggerSupport.framework"];
    if (![b load])
    {
        @throw [NSError errorWithDomain:@"I am built for iOS 7 and will crash if this framework does not exist" code:0 userInfo:nil];
    }
}

//return battery data.  Battery Data is a subclass of PLEntry
id PL_BatteryData(void)
{
    Class PLBatteryPropertiesEntry = NSClassFromString(@"PLBatteryPropertiesEntry");
    
    //uncomment this line for a dump of the entry
    //NSLog(@"PLBatteryPropertiesEntry %@",[PLBatteryPropertiesEntry performSelector:@selector(batteryPropertiesEntry)]);
    
    id entry = [PLBatteryPropertiesEntry performSelector:@selector(batteryPropertiesEntry)];
    
    return entry;
}

//run tests
void PL_Tests(void)
{
    NSLog(@"************************BEGIN TESTS");
    NSLog(@"************************DEVICE INFO");
    Class PLUtilities = NSClassFromString(@"PLUtilities");
    NSMutableArray *strings = [NSMutableArray array];
    
    [strings addObject:[PLUtilities performSelector:@selector(UUIDString)]];
    [strings addObject:[PLUtilities performSelector:@selector(buildVersion)]];
    [strings addObject:[PLUtilities performSelector:@selector(deviceName)]];
    [strings addObject:[PLUtilities performSelector:@selector(hardwareModel)]];
    [strings addObject:[PLUtilities performSelector:@selector(runningAsUser)]];
    [strings addObject:[PLUtilities performSelector:@selector(wifiChipset)]];
    
    for (NSString *string in strings)
    {
        NSLog(@"%@",string);
    }
    
    NSLog(@"***********************BATTERY INFO");
    id entry = PL_BatteryData();
    NSArray *keys = [NSArray arrayWithArray:[entry valueForKey:@"keys"]];
    for (NSString *key in keys)
    {
        NSLog(@"%@ %@",key,[entry objectForKey:key]);
    }
    
    NSLog(@"**************************END TESTS");
}