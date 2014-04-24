//
//  NBPLUtil.h
//  iOS7Battery
//
//  Created by nailbones on 4/24/14.
//  Copyright (c) 2014 nailbones. All rights reserved.
//
// !!WARNING!! THIS CLASS USES PRIVATE FRAMEWORKS
// THIS IS ONLY FOR DEVELOPMENT PURPOSES
// USE AT YOUR OWN RISK

#import <Foundation/Foundation.h>

#if TARGET_IPHONE_SIMULATOR
#error iOS7Battery only works on physical iOS devices
#endif

void PL_LoadFramework(void);
void PL_Tests(void);
id PL_BatteryData(void);
