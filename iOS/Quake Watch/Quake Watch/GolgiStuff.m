//
//  GolgiStuff.m
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "GolgiStuff.h"
#import "AppData.h"
#import "GOLGI_KEYS.h"
#import "QuakeWatchSvcWrapper.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

static double calcDistance(double lat1, double lng1, double lat2, double lng2){
    double r = 6371; // km
    double dLat = DEGREES_TO_RADIANS(lat2-lat1);
    double dLng = DEGREES_TO_RADIANS(lng2-lng1);
    
    lat1 = DEGREES_TO_RADIANS(lat1);
    lat2 = DEGREES_TO_RADIANS(lat2);
        
    double a = sin(dLat/2.0) * sin(dLat/2.0) +
    sin(dLng/2.0) * sin(dLng/2.0) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(a), sqrt(1.0-a));
    double d = r * c;
        
    return (floor(d * 10.0)) / 10.0;
}
    
    
static double getBearing(double lat1, double lng1, double lat2, double lng2){

    // double dLat = DEGREES_TO_RADIANS(lat2-lat1);
    double dLng = DEGREES_TO_RADIANS(lng2-lng1);
    
    lat1 = DEGREES_TO_RADIANS(lat1);
    lat2 = DEGREES_TO_RADIANS(lat2);
        
    lng1 = DEGREES_TO_RADIANS(lng1);
    lng2 = DEGREES_TO_RADIANS(lng2);
        
        
    double y = sin(dLng) * cos(lat2);
    double x = cos(lat1) * sin(lat2) -
        sin(lat1) * cos(lat2) * cos(dLng);
    double brng = DEGREES_TO_RADIANS(atan2(y, x));
        
    return brng;
}
    
static char *bearingWords[] = {
    "North", "Northeast", "East", "Southeast", "South", "Southwest", "West", "Northwest", "North"
};
    
static NSString *getBearingAsString(double lat1, double lng1, double lat2, double lng2){
    
    double b = getBearing(lat1, lng1, lat2, lng2);
    double b1 = b += 22.5;
        
    if(b1 < 0){
        b1 += 360.0;
    }
        
    if(b1 >= 360.0){
        b1 -= 360.0;
    }
        
    int idx = (int)b1 / 45;
        
    return [NSString stringWithUTF8String:bearingWords[idx]];
}

@interface DistanceCalculator : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locMgr;
    QuakeDetails *quakeDetails;
    NSMutableArray *calculators;
}
@end
@implementation DistanceCalculator

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [locMgr stopUpdatingLocation];
    NSLog(@"A");
    
    
    double d = calcDistance(newLocation.coordinate.latitude, newLocation.coordinate.longitude, quakeDetails.getLat, quakeDetails.getLng);
    NSLog(@"B");
    NSString *bearing = getBearingAsString(newLocation.coordinate.latitude, newLocation.coordinate.longitude, quakeDetails.getLat, quakeDetails.getLng);
    NSLog(@"C");
    
    if([quakeDetails getMag] >= [AppData getNfnThreshold]){
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = [NSString stringWithFormat:@"%d Km %@: %@", (int)d, bearing, [quakeDetails getTitle]];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"D");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        NSLog(@"E");
    }
    
    NSLog(@"F");
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(double)[quakeDetails getTimestamp]];
    
    NSString *dstr = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    NSLog(@"Date: %ld %@", (long)[quakeDetails getTimestamp], dstr);
    
    NSMutableString *log = [NSMutableString stringWithString:[AppData getQuakeLog]];
    [log appendFormat:@"%@ %d Km %@\n         %@\n", dstr, (int)d, bearing, [quakeDetails getTitle]];
    
    NSUInteger len = [log length];
    if(len > 600){
        NSLog(@"Prunage");
        log = [NSMutableString stringWithString:[log substringFromIndex:(len - 400)]];
    }
    else{
        NSLog(@"No Prunage");
    }
    
    [AppData setQuakeLog:log];
    NSLog(@"Log is now: '%@'", log);
    
    [calculators removeObject:self];
    
    NSLog(@"Calculators adjusted");
    // locMgr = nil;
    NSLog(@"locMgr de-referenced");
}

- (void)start
{
    [locMgr startUpdatingLocation];
}

- (DistanceCalculator *) initWithQuakeDetails:(QuakeDetails *)_quakeDetails andArray:(NSMutableArray *)_calculators
{
    self = [self init];
    quakeDetails = _quakeDetails;
    calculators = _calculators;
    
    locMgr = [[CLLocationManager alloc] init];
    locMgr.delegate = self;
    locMgr.distanceFilter = kCLDistanceFilterNone;
    locMgr.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    return self;
}
@end

@interface _AddMeResultReceiver: NSObject <QuakeWatchAddMeResultReceiver>
@end
@implementation _AddMeResultReceiver
- (void)success
{
    NSLog(@"addMe: SUCCESS");
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
    NSLog(@"addMe: FAILED '%@'", [golgiException getErrText]);
}

@end

@interface CombinedRequestReceiver: NSObject <QuakeWatchQuakeAlertRequestReceiver>
{
    ViewController *viewController;
    NSMutableArray *calculators;
}
- (CombinedRequestReceiver *)initWithViewController:(ViewController *)viewController;
@end
@implementation CombinedRequestReceiver

- (void) quakeAlertWithResultSender:(id<QuakeWatchQuakeAlertResultSender>)resultSender andDetails:(QuakeDetails *)details
{
    NSLog(@"Quake Alert: '%@'", [details getTitle]);
    
    DistanceCalculator *ds = [[DistanceCalculator alloc] initWithQuakeDetails:details andArray:calculators];
    
    [calculators addObject:ds];
    
    NSLog(@"Calculator allocated and setup");
    
    [ds start];

    NSLog(@"Calculator started");
    
    [resultSender success];
    
    NSLog(@"We're all done");
}

- (CombinedRequestReceiver *)initWithViewController:(ViewController *)_viewController
{
    self = [self init];
    viewController = _viewController;
    calculators = [[NSMutableArray alloc]init];
    return self;
}

@end



@implementation GolgiStuff





// GOLGI
//********************************* Registration ***************************
//
// Setup handling of inbound SendMessage methods and then Register with Golgi
//
- (void)doGolgiRegistration
{
    //
    // Do this before registration because on registering, there may be messages queued
    // up for us that would arrive and be rejected because there is no handler in place
    //
    
    // [TapTelegraphSvc registerSendMessageRequestReceiver:self];
    
    //
    // and now do the main registration with the service
    //
    NSLog(@"Registering with golgiId: '%@'", ourId);
    // [Golgi setOption:@"USE_DEV_CLUSTER" withValue:@"0"];
    
    CombinedRequestReceiver *crr = [[CombinedRequestReceiver alloc] initWithViewController:viewController];
    
    [QuakeWatchSvc registerQuakeAlertRequestReceiver:crr];

    
    [Golgi registerWithDevId:GOLGI_DEV_KEY
                       appId:GOLGI_APP_KEY
                      instId:ourId
                  andAPIUser:self];
}

//
// Registration worked
//

- (void)golgiRegistrationSuccess
{
    QuakeFilter *qf;
    NSLog(@"Golgi Registration: PASS");
    
    qf = [[QuakeFilter alloc] initWithIsSet:true];
    
    [qf setGolgiId: ourId];
    [qf setLat:0.0];
    [qf setLng:0.0];
    [qf setRadius:0.0];
    
    

    [QuakeWatchSvc sendAddMeUsingResultReceiver:[[_AddMeResultReceiver alloc]init]
                           withTransportOptions:stdGto
                                 andDestination:@"SERVER"
                                     withFilter:qf];

}

//
// Registration failed
//

- (void)golgiRegistrationFailure:(NSString *)errorText
{
    NSLog(@"Golgi Registration: FAIL => '%@'", errorText);
}

- (void)setPushId:(NSString *)_pushId
{
    if([pushId  compare:_pushId] != NSOrderedSame){
        pushId = _pushId;
        [self doGolgiRegistration];
    }
}

- (NSString *)pushTokenToString:(NSData *)token
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    
    for(int i = 0; i < token.length; i++){
        [hexStr appendFormat:@"%02x", ((unsigned char *)[token bytes])[i]];
    }
    
    return [NSString stringWithString:hexStr];
}

- (GolgiStuff *)initWithViewController:(ViewController *)_viewController
{
    self = [self init];
    viewController = _viewController;
    
    stdGto = [[GolgiTransportOptions alloc] init];
    [stdGto setValidityPeriodInSeconds:60];

    
    ourId = [AppData getInstanceId];
    if(ourId.length == 0){
        NSMutableString *str = [[NSMutableString alloc]init];
        
        srand48((long)CACurrentMediaTime());
        for(int i = 0; i < 20; i++){
            char ch;
            ch = lrand48() % 62;
            if(ch < 26){
                ch = 'A' + ch;
            }
            else if(ch < 52){
                ch = 'a' + (ch - 26);
            }
            else{
                ch = '0' + (ch - 52);
            }
            [str appendFormat:@"%c", ch];
        }
        
        ourId = [NSString stringWithString:str];
        [AppData setInstanceId:ourId];
    }
    
    NSLog(@"Instance Id: '%@'", ourId);
    
    pushId = @"";
    
    
    [self doGolgiRegistration];
    
    return self;
}

@end
