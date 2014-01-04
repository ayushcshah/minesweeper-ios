//
//  AppSingleton.m
//  Minesweep
//
//  Created by Ayush Shah on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppSingleton.h"

@implementation AppSingleton
@synthesize x;
@synthesize y;

static AppSingleton *sharedInstance;

+ (AppSingleton *)sharedInstance {
    if(!sharedInstance) {
        sharedInstance = [[AppSingleton alloc] init];
    }
    return sharedInstance;
}
- (id)init {
    self = [super init];
    if(self) {
    }
    return self;
}


@end
