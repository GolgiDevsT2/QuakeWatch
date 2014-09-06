//
//  GolgiStuff.h
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "QuakeWatchSvcWrapper.h"
#import "ViewController.h"

@class ViewController;

@interface GolgiStuff : NSObject <GolgiAPIUser>
{
    ViewController *viewController;
    NSString *ourId;
    NSString *pushId;
    GolgiTransportOptions *stdGto;
}
- (NSString *)pushTokenToString:(NSData *)token;
- (void)setPushId:(NSString *)_pushId;
- (GolgiStuff *)initWithViewController:(ViewController *)viewController;


@end
