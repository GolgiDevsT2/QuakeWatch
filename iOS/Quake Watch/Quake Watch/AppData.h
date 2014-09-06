//
//  AppData.h
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject
{
    NSString *instanceId;
    NSString *quakeLog;
    NSInteger nfnThreshold;
}

+ (NSString *)getInstanceId;
+ (void)setInstanceId:(NSString *)instanceId;

+ (NSString *)getQuakeLog;
+ (void)setQuakeLog:(NSString *)instanceId;

+ (NSInteger)getNfnThreshold;
+ (void)setNfnThreshold:(NSInteger) threshold;
@end
