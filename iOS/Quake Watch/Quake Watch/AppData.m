//
//  AppData.m
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "AppData.h"

static AppData *instance = nil;


@implementation AppData

+ (AppData *)getInstance
{
    if(instance == nil){
        instance = [[AppData alloc] init];
    }
    
    return instance;
}

+ (NSString *)getInstanceId
{
    return [[AppData getInstance] _getInstanceId];
}

+ (void)setInstanceId:(NSString *)_instanceId
{
    [[AppData getInstance] _setInstanceId:_instanceId];
}

+ (NSString *)getQuakeLog
{
    return [[AppData getInstance] _getQuakeLog];
}

+ (void)setQuakeLog:(NSString *)_quakeLog
{
    [[AppData getInstance] _setQuakeLog:_quakeLog];
}

+ (NSInteger)getNfnThreshold
{
    return [[AppData getInstance] _getNfnThreshold];
}


+ (void)setNfnThreshold:(NSInteger) threshold
{
    [[AppData getInstance] _setNfnThreshold:threshold];
}



/*********************************************************************/

- (NSString *)_getInstanceId
{
    return instanceId;
}

- (void)_setInstanceId:(NSString *)_instanceId
{
    instanceId = _instanceId;
    [self save];
}

- (NSString *)_getQuakeLog
{
    return quakeLog;
}

- (void)_setQuakeLog:(NSString *)_quakeLog
{
    quakeLog = _quakeLog;
    [self save];
}

- (NSInteger)_getNfnThreshold
{
    return nfnThreshold;
}

- (void)_setNfnThreshold:(NSInteger)_nfnThreshold
{
    nfnThreshold = _nfnThreshold;
    [self save];
}


- (void)save
{
    NSString *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"AppData.plist"];
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects:
                                [NSString stringWithString:instanceId],
                                [NSString stringWithString:quakeLog],
                                [NSString stringWithFormat:@"%ld", (long)nfnThreshold],
                                nil]
                               
                                                          forKeys:[NSArray arrayWithObjects:
                                                                   @"instanceId",
                                                                   @"quakeLog",
                                                                   @"nfnThreshold",
                                                                   nil]
                               ];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"Error Writing GameData: %@", error);
    }
}

- (AppData *)init
{
    self = [super init];
    
    instanceId = @"";
    quakeLog = @"";
    nfnThreshold = 0;
    
    NSString *str;
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"AppData.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"AppData" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, (int)format);
    }
    else {
        if((str = [temp objectForKey:@"instanceId"]) != nil){
            instanceId = str;
        }
        if((str = [temp objectForKey:@"quakeLog"]) != nil){
            quakeLog = str;
        }
        if((str = [temp objectForKey:@"nfnThreshold"]) != nil){
            nfnThreshold = atol([str UTF8String]);
        }
    }
    
    NSLog(@"  Instance Id: '%@'", instanceId);
    
    return self;
}



@end
