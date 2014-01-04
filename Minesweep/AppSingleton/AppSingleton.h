//
//  AppSingleton.h
//  Minesweep
//
//  Created by Ayush Shah on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSingleton : NSObject
@property(nonatomic,assign) NSInteger x;
@property(nonatomic,assign) NSInteger y;

+ (AppSingleton *)sharedInstance;
@end
