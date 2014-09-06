/* IS_AUTOGENERATED_SO_ALLOW_AUTODELETE=YES */
/* The previous line is to allow auto deletion */

#import "QuakeWatchSvcGen.h"

@implementation QuakeFilter

@synthesize golgiIdIsSet;
- (NSString *)getGolgiId
{
    return golgiId;
}
- (void)setGolgiId:(NSString *)_golgiId
{
    golgiId = _golgiId;
    golgiIdIsSet = (_golgiId != nil) ? YES : NO;
}
@synthesize latIsSet;
- (double)getLat
{
    return lat;
}
- (void)setLat:(double )_lat
{
    lat = _lat;
    latIsSet = YES;
}
@synthesize lngIsSet;
- (double)getLng
{
    return lng;
}
- (void)setLng:(double )_lng
{
    lng = _lng;
    lngIsSet = YES;
}
@synthesize radiusIsSet;
- (double)getRadius
{
    return radius;
}
- (void)setRadius:(double )_radius
{
    radius = _radius;
    radiusIsSet = YES;
}

+ (QuakeFilter *)deserialiseFromString: (NSString *)string
{
    return [QuakeFilter deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}

+ (QuakeFilter *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeFilter *inst = [[QuakeFilter alloc] initWithIsSet:NO];
    BOOL corrupt = NO;

    {
        NSString *str;
        if((str = [payload getStringWithTag:@"1:"]) != nil){
            inst.golgiId = str;
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSNumber *num;
        if((num = [payload getDoubleWithTag:@"2:"]) != nil){
            inst.lat = [num doubleValue];
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSNumber *num;
        if((num = [payload getDoubleWithTag:@"3:"]) != nil){
            inst.lng = [num doubleValue];
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSNumber *num;
        if((num = [payload getDoubleWithTag:@"4:"]) != nil){
            inst.radius = [num doubleValue];
        }
        else{
            corrupt = YES;
        }
    }

    return (corrupt) ? nil : inst;
}

- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}

- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];

    if(golgiIdIsSet){
        [str appendFormat:@"%@1: \"%@\"\n", prefix, [CSL  NTLEscapeString:golgiId]];
    }
    if(latIsSet){
        [str appendFormat:@"%@2: %@\n", prefix, [CSL doubleToStr:lat]];
    }
    if(lngIsSet){
        [str appendFormat:@"%@3: %@\n", prefix, [CSL doubleToStr:lng]];
    }
    if(radiusIsSet){
        [str appendFormat:@"%@4: %@\n", prefix, [CSL doubleToStr:radius]];
    }

    return [NSString stringWithString:str];
}

- (QuakeFilter *)init
{
    return [self initWithIsSet:YES];
}

- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        golgiId = @"";
        golgiIdIsSet = defIsSet;
        latIsSet = defIsSet;
        lngIsSet = defIsSet;
        radiusIsSet = defIsSet;
    }

    return self;

}

@end
@implementation QuakeDetails

@synthesize magIsSet;
- (double)getMag
{
    return mag;
}
- (void)setMag:(double )_mag
{
    mag = _mag;
    magIsSet = YES;
}
@synthesize latIsSet;
- (double)getLat
{
    return lat;
}
- (void)setLat:(double )_lat
{
    lat = _lat;
    latIsSet = YES;
}
@synthesize lngIsSet;
- (double)getLng
{
    return lng;
}
- (void)setLng:(double )_lng
{
    lng = _lng;
    lngIsSet = YES;
}
@synthesize titleIsSet;
- (NSString *)getTitle
{
    return title;
}
- (void)setTitle:(NSString *)_title
{
    title = _title;
    titleIsSet = (_title != nil) ? YES : NO;
}
@synthesize timestampIsSet;
- (NSInteger)getTimestamp
{
    return timestamp;
}
- (void)setTimestamp:(NSInteger )_timestamp
{
    timestamp = _timestamp;
    timestampIsSet = YES;
}

+ (QuakeDetails *)deserialiseFromString: (NSString *)string
{
    return [QuakeDetails deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}

+ (QuakeDetails *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeDetails *inst = [[QuakeDetails alloc] initWithIsSet:NO];
    BOOL corrupt = NO;

    {
        NSNumber *num;
        if((num = [payload getDoubleWithTag:@"1:"]) != nil){
            inst.mag = [num doubleValue];
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSNumber *num;
        if((num = [payload getDoubleWithTag:@"2:"]) != nil){
            inst.lat = [num doubleValue];
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSNumber *num;
        if((num = [payload getDoubleWithTag:@"3:"]) != nil){
            inst.lng = [num doubleValue];
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSString *str;
        if((str = [payload getStringWithTag:@"4:"]) != nil){
            inst.title = str;
        }
        else{
            corrupt = YES;
        }
    }

    {
        NSNumber *num;
        if((num = [payload getIntWithTag:@"5:"]) != nil){
            inst.timestamp = [num intValue];
        }
        else{
            corrupt = YES;
        }
    }

    return (corrupt) ? nil : inst;
}

- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}

- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];

    if(magIsSet){
        [str appendFormat:@"%@1: %@\n", prefix, [CSL doubleToStr:mag]];
    }
    if(latIsSet){
        [str appendFormat:@"%@2: %@\n", prefix, [CSL doubleToStr:lat]];
    }
    if(lngIsSet){
        [str appendFormat:@"%@3: %@\n", prefix, [CSL doubleToStr:lng]];
    }
    if(titleIsSet){
        [str appendFormat:@"%@4: \"%@\"\n", prefix, [CSL  NTLEscapeString:title]];
    }
    if(timestampIsSet){
        [str appendFormat:@"%@5: %ld\n", prefix, (long)timestamp];
    }

    return [NSString stringWithString:str];
}

- (QuakeDetails *)init
{
    return [self initWithIsSet:YES];
}

- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        magIsSet = defIsSet;
        latIsSet = defIsSet;
        lngIsSet = defIsSet;
        title = @"";
        titleIsSet = defIsSet;
        timestampIsSet = defIsSet;
    }

    return self;

}

@end
@implementation QuakeWatch_addMe_reqArg
@synthesize filterIsSet;
- (QuakeFilter *)getFilter
{
    return filter;
}
- (void)setFilter:(QuakeFilter *)_filter
{
    filter = _filter;
    filterIsSet = (_filter != nil) ? YES : NO;
}
+ (QuakeWatch_addMe_reqArg *)deserialiseFromString: (NSString *)string
{
    return [QuakeWatch_addMe_reqArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (QuakeWatch_addMe_reqArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeWatch_addMe_reqArg *inst = [[QuakeWatch_addMe_reqArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"1"]) != nil){
            [inst setFilter:[QuakeFilter deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setFilter:nil];
        }
    }
    if([inst getFilter] == nil){
        corrupt = YES;
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(filterIsSet){
        [str appendString:[filter serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "1"]]];
    }
    return [NSString stringWithString:str];
}
- (QuakeWatch_addMe_reqArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        filter = [[QuakeFilter alloc] initWithIsSet:defIsSet];
        filterIsSet = defIsSet;
    }
    return self;
}
@end
@implementation QuakeWatch_addMe_rspArg
@synthesize internalSuccess_IsSet;
- (NSInteger)getInternalSuccess_
{
    return internalSuccess_;
}
- (void)setInternalSuccess_:(NSInteger )_internalSuccess_
{
    internalSuccess_ = _internalSuccess_;
    internalSuccess_IsSet = YES;
}
@synthesize golgiExceptionIsSet;
- (GolgiException *)getGolgiException
{
    return golgiException;
}
- (void)setGolgiException:(GolgiException *)_golgiException
{
    golgiException = _golgiException;
    golgiExceptionIsSet = (_golgiException != nil) ? YES : NO;
}
+ (QuakeWatch_addMe_rspArg *)deserialiseFromString: (NSString *)string
{
    return [QuakeWatch_addMe_rspArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (QuakeWatch_addMe_rspArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeWatch_addMe_rspArg *inst = [[QuakeWatch_addMe_rspArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        NSNumber *num;
        if((num = [payload getIntWithTag:@"1:"]) != nil){
            inst.internalSuccess_ = [num intValue];
        }
    }
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"3"]) != nil){
            [inst setGolgiException:[GolgiException deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setGolgiException:nil];
        }
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(internalSuccess_IsSet){
        [str appendFormat:@"%@1: %ld\n", prefix, (long)internalSuccess_];
    }
    if(golgiExceptionIsSet){
        [str appendString:[golgiException serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "3"]]];
    }
    return [NSString stringWithString:str];
}
- (QuakeWatch_addMe_rspArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        golgiException = [[GolgiException alloc] initWithIsSet:defIsSet];
    }
    return self;
}
@end
@implementation QuakeWatch_removeMe_reqArg
@synthesize golgiIdIsSet;
- (NSString *)getGolgiId
{
    return golgiId;
}
- (void)setGolgiId:(NSString *)_golgiId
{
    golgiId = _golgiId;
    golgiIdIsSet = (_golgiId != nil) ? YES : NO;
}
+ (QuakeWatch_removeMe_reqArg *)deserialiseFromString: (NSString *)string
{
    return [QuakeWatch_removeMe_reqArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (QuakeWatch_removeMe_reqArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeWatch_removeMe_reqArg *inst = [[QuakeWatch_removeMe_reqArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        NSString *str;
        if((str = [payload getStringWithTag:@"1:"]) != nil){
            inst.golgiId = str;
        }
        else{
            corrupt = YES;
        }
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(golgiIdIsSet){
        [str appendFormat:@"%@1: \"%@\"\n", prefix, [CSL  NTLEscapeString:golgiId]];
    }
    return [NSString stringWithString:str];
}
- (QuakeWatch_removeMe_reqArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        golgiId = @"";
        golgiIdIsSet = defIsSet;
    }
    return self;
}
@end
@implementation QuakeWatch_removeMe_rspArg
@synthesize internalSuccess_IsSet;
- (NSInteger)getInternalSuccess_
{
    return internalSuccess_;
}
- (void)setInternalSuccess_:(NSInteger )_internalSuccess_
{
    internalSuccess_ = _internalSuccess_;
    internalSuccess_IsSet = YES;
}
@synthesize golgiExceptionIsSet;
- (GolgiException *)getGolgiException
{
    return golgiException;
}
- (void)setGolgiException:(GolgiException *)_golgiException
{
    golgiException = _golgiException;
    golgiExceptionIsSet = (_golgiException != nil) ? YES : NO;
}
+ (QuakeWatch_removeMe_rspArg *)deserialiseFromString: (NSString *)string
{
    return [QuakeWatch_removeMe_rspArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (QuakeWatch_removeMe_rspArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeWatch_removeMe_rspArg *inst = [[QuakeWatch_removeMe_rspArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        NSNumber *num;
        if((num = [payload getIntWithTag:@"1:"]) != nil){
            inst.internalSuccess_ = [num intValue];
        }
    }
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"3"]) != nil){
            [inst setGolgiException:[GolgiException deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setGolgiException:nil];
        }
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(internalSuccess_IsSet){
        [str appendFormat:@"%@1: %ld\n", prefix, (long)internalSuccess_];
    }
    if(golgiExceptionIsSet){
        [str appendString:[golgiException serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "3"]]];
    }
    return [NSString stringWithString:str];
}
- (QuakeWatch_removeMe_rspArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        golgiException = [[GolgiException alloc] initWithIsSet:defIsSet];
    }
    return self;
}
@end
@implementation QuakeWatch_quakeAlert_reqArg
@synthesize detailsIsSet;
- (QuakeDetails *)getDetails
{
    return details;
}
- (void)setDetails:(QuakeDetails *)_details
{
    details = _details;
    detailsIsSet = (_details != nil) ? YES : NO;
}
+ (QuakeWatch_quakeAlert_reqArg *)deserialiseFromString: (NSString *)string
{
    return [QuakeWatch_quakeAlert_reqArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (QuakeWatch_quakeAlert_reqArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeWatch_quakeAlert_reqArg *inst = [[QuakeWatch_quakeAlert_reqArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"1"]) != nil){
            [inst setDetails:[QuakeDetails deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setDetails:nil];
        }
    }
    if([inst getDetails] == nil){
        corrupt = YES;
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(detailsIsSet){
        [str appendString:[details serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "1"]]];
    }
    return [NSString stringWithString:str];
}
- (QuakeWatch_quakeAlert_reqArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        details = [[QuakeDetails alloc] initWithIsSet:defIsSet];
        detailsIsSet = defIsSet;
    }
    return self;
}
@end
@implementation QuakeWatch_quakeAlert_rspArg
@synthesize internalSuccess_IsSet;
- (NSInteger)getInternalSuccess_
{
    return internalSuccess_;
}
- (void)setInternalSuccess_:(NSInteger )_internalSuccess_
{
    internalSuccess_ = _internalSuccess_;
    internalSuccess_IsSet = YES;
}
@synthesize golgiExceptionIsSet;
- (GolgiException *)getGolgiException
{
    return golgiException;
}
- (void)setGolgiException:(GolgiException *)_golgiException
{
    golgiException = _golgiException;
    golgiExceptionIsSet = (_golgiException != nil) ? YES : NO;
}
+ (QuakeWatch_quakeAlert_rspArg *)deserialiseFromString: (NSString *)string
{
    return [QuakeWatch_quakeAlert_rspArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (QuakeWatch_quakeAlert_rspArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    QuakeWatch_quakeAlert_rspArg *inst = [[QuakeWatch_quakeAlert_rspArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        NSNumber *num;
        if((num = [payload getIntWithTag:@"1:"]) != nil){
            inst.internalSuccess_ = [num intValue];
        }
    }
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"3"]) != nil){
            [inst setGolgiException:[GolgiException deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setGolgiException:nil];
        }
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(internalSuccess_IsSet){
        [str appendFormat:@"%@1: %ld\n", prefix, (long)internalSuccess_];
    }
    if(golgiExceptionIsSet){
        [str appendString:[golgiException serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "3"]]];
    }
    return [NSString stringWithString:str];
}
- (QuakeWatch_quakeAlert_rspArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        golgiException = [[GolgiException alloc] initWithIsSet:defIsSet];
    }
    return self;
}
@end

@interface AddMeInternalResultSender : NSObject <QuakeWatchAddMeResultSender>
{
    NSString *sender;
    NSString *msgId;
    QuakeWatch_addMe_rspArg *rsp;
}
- (AddMeInternalResultSender *) initWithSender:(NSString *)sender andMessageId:(NSString *)msgId;
@end
@implementation AddMeInternalResultSender
- (AddMeInternalResultSender *) initWithSender:(NSString *)_sender andMessageId:(NSString *)_msgId
{
    self = [self init];
    sender = _sender;
    msgId = _msgId;
    rsp = [[QuakeWatch_addMe_rspArg alloc] initWithIsSet:NO];

    return self;
}

- (void)sendResponse
{
    [Golgi sendResponsePayload:[rsp serialise] to:sender forMethod:@"addMe.QuakeWatch" withMessageId:msgId];
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
    [rsp setGolgiException:golgiException];
    [self sendResponse];
}

- (void)success
{
    [rsp setInternalSuccess_:1];
    [self sendResponse];
}

@end

@interface AddMeInternalRequestHandler : NSObject <GolgiInternalInboundRequestHandler>
{
    id<QuakeWatchAddMeRequestReceiver> receiver;
}

- (AddMeInternalRequestHandler *)initWithReceiver:(id<QuakeWatchAddMeRequestReceiver>)receiver;
@end

@implementation AddMeInternalRequestHandler

- (void)incomingMsg:(NSString *)payload from:(NSString *)sender withMessageId:(NSString *)msgId
{
    QuakeWatch_addMe_reqArg *req = [QuakeWatch_addMe_reqArg deserialiseFromString:payload];

    if(req == nil){
        [Golgi sendRemoteError:@"Garbled Payload at Remote End" to:sender forMethod:@"addMe.QuakeWatch" withMessageId:msgId];
    }
    else{
        // Process req here
        AddMeInternalResultSender *resultSender;
        resultSender = [AddMeInternalResultSender alloc];
        resultSender = [resultSender initWithSender:sender andMessageId:msgId];
        [receiver addMeWithResultSender:resultSender andFilter:[req getFilter]];
    }
}

- (AddMeInternalRequestHandler *)initWithReceiver:(id<QuakeWatchAddMeRequestReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;

    return self;
}
@end

@interface AddMeInternalResponseHandler : NSObject <GolgiInternalInboundResponseHandler>
{
    id<QuakeWatchAddMeResultReceiver> receiver;
}

- (AddMeInternalResponseHandler *)initWithReceiver:(id<QuakeWatchAddMeResultReceiver>)receiver;
@end
@implementation AddMeInternalResponseHandler

- (void)processResponsePayload:(NSString *)payload
{
    QuakeWatch_addMe_rspArg *rsp = [QuakeWatch_addMe_rspArg deserialiseFromString:payload];

    if(rsp == nil){
        GolgiException *golgiException = [[GolgiException alloc]init];

        [golgiException setErrText:@"Corrupt Response"];
        [golgiException setErrType:GOLGI_ERRTYPE_PAYLOAD_MISMATCH];
        [receiver failureWithGolgiException:golgiException];
    }
    else if(rsp.internalSuccess_IsSet && ([rsp getInternalSuccess_] != 0)){
        [receiver success];
    }
    else if(rsp.golgiExceptionIsSet){
        [receiver failureWithGolgiException:[rsp getGolgiException]];
    }
    else{
        NSLog(@"WARNING: result for 'addMe' in Golgi Service 'QuakeWatch' has no expected response fields set!");
    }

}

- (void)processGolgiException:(GolgiException *)golgiException
{
	[receiver failureWithGolgiException:golgiException];
}

- (AddMeInternalResponseHandler *)initWithReceiver:(id<QuakeWatchAddMeResultReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;
    return self;
}

@end


@interface RemoveMeInternalResultSender : NSObject <QuakeWatchRemoveMeResultSender>
{
    NSString *sender;
    NSString *msgId;
    QuakeWatch_removeMe_rspArg *rsp;
}
- (RemoveMeInternalResultSender *) initWithSender:(NSString *)sender andMessageId:(NSString *)msgId;
@end
@implementation RemoveMeInternalResultSender
- (RemoveMeInternalResultSender *) initWithSender:(NSString *)_sender andMessageId:(NSString *)_msgId
{
    self = [self init];
    sender = _sender;
    msgId = _msgId;
    rsp = [[QuakeWatch_removeMe_rspArg alloc] initWithIsSet:NO];

    return self;
}

- (void)sendResponse
{
    [Golgi sendResponsePayload:[rsp serialise] to:sender forMethod:@"removeMe.QuakeWatch" withMessageId:msgId];
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
    [rsp setGolgiException:golgiException];
    [self sendResponse];
}

- (void)success
{
    [rsp setInternalSuccess_:1];
    [self sendResponse];
}

@end

@interface RemoveMeInternalRequestHandler : NSObject <GolgiInternalInboundRequestHandler>
{
    id<QuakeWatchRemoveMeRequestReceiver> receiver;
}

- (RemoveMeInternalRequestHandler *)initWithReceiver:(id<QuakeWatchRemoveMeRequestReceiver>)receiver;
@end

@implementation RemoveMeInternalRequestHandler

- (void)incomingMsg:(NSString *)payload from:(NSString *)sender withMessageId:(NSString *)msgId
{
    QuakeWatch_removeMe_reqArg *req = [QuakeWatch_removeMe_reqArg deserialiseFromString:payload];

    if(req == nil){
        [Golgi sendRemoteError:@"Garbled Payload at Remote End" to:sender forMethod:@"removeMe.QuakeWatch" withMessageId:msgId];
    }
    else{
        // Process req here
        RemoveMeInternalResultSender *resultSender;
        resultSender = [RemoveMeInternalResultSender alloc];
        resultSender = [resultSender initWithSender:sender andMessageId:msgId];
        [receiver removeMeWithResultSender:resultSender andGolgiId:[req getGolgiId]];
    }
}

- (RemoveMeInternalRequestHandler *)initWithReceiver:(id<QuakeWatchRemoveMeRequestReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;

    return self;
}
@end

@interface RemoveMeInternalResponseHandler : NSObject <GolgiInternalInboundResponseHandler>
{
    id<QuakeWatchRemoveMeResultReceiver> receiver;
}

- (RemoveMeInternalResponseHandler *)initWithReceiver:(id<QuakeWatchRemoveMeResultReceiver>)receiver;
@end
@implementation RemoveMeInternalResponseHandler

- (void)processResponsePayload:(NSString *)payload
{
    QuakeWatch_removeMe_rspArg *rsp = [QuakeWatch_removeMe_rspArg deserialiseFromString:payload];

    if(rsp == nil){
        GolgiException *golgiException = [[GolgiException alloc]init];

        [golgiException setErrText:@"Corrupt Response"];
        [golgiException setErrType:GOLGI_ERRTYPE_PAYLOAD_MISMATCH];
        [receiver failureWithGolgiException:golgiException];
    }
    else if(rsp.internalSuccess_IsSet && ([rsp getInternalSuccess_] != 0)){
        [receiver success];
    }
    else if(rsp.golgiExceptionIsSet){
        [receiver failureWithGolgiException:[rsp getGolgiException]];
    }
    else{
        NSLog(@"WARNING: result for 'removeMe' in Golgi Service 'QuakeWatch' has no expected response fields set!");
    }

}

- (void)processGolgiException:(GolgiException *)golgiException
{
	[receiver failureWithGolgiException:golgiException];
}

- (RemoveMeInternalResponseHandler *)initWithReceiver:(id<QuakeWatchRemoveMeResultReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;
    return self;
}

@end


@interface QuakeAlertInternalResultSender : NSObject <QuakeWatchQuakeAlertResultSender>
{
    NSString *sender;
    NSString *msgId;
    QuakeWatch_quakeAlert_rspArg *rsp;
}
- (QuakeAlertInternalResultSender *) initWithSender:(NSString *)sender andMessageId:(NSString *)msgId;
@end
@implementation QuakeAlertInternalResultSender
- (QuakeAlertInternalResultSender *) initWithSender:(NSString *)_sender andMessageId:(NSString *)_msgId
{
    self = [self init];
    sender = _sender;
    msgId = _msgId;
    rsp = [[QuakeWatch_quakeAlert_rspArg alloc] initWithIsSet:NO];

    return self;
}

- (void)sendResponse
{
    [Golgi sendResponsePayload:[rsp serialise] to:sender forMethod:@"quakeAlert.QuakeWatch" withMessageId:msgId];
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
    [rsp setGolgiException:golgiException];
    [self sendResponse];
}

- (void)success
{
    [rsp setInternalSuccess_:1];
    [self sendResponse];
}

@end

@interface QuakeAlertInternalRequestHandler : NSObject <GolgiInternalInboundRequestHandler>
{
    id<QuakeWatchQuakeAlertRequestReceiver> receiver;
}

- (QuakeAlertInternalRequestHandler *)initWithReceiver:(id<QuakeWatchQuakeAlertRequestReceiver>)receiver;
@end

@implementation QuakeAlertInternalRequestHandler

- (void)incomingMsg:(NSString *)payload from:(NSString *)sender withMessageId:(NSString *)msgId
{
    QuakeWatch_quakeAlert_reqArg *req = [QuakeWatch_quakeAlert_reqArg deserialiseFromString:payload];

    if(req == nil){
        [Golgi sendRemoteError:@"Garbled Payload at Remote End" to:sender forMethod:@"quakeAlert.QuakeWatch" withMessageId:msgId];
    }
    else{
        // Process req here
        QuakeAlertInternalResultSender *resultSender;
        resultSender = [QuakeAlertInternalResultSender alloc];
        resultSender = [resultSender initWithSender:sender andMessageId:msgId];
        [receiver quakeAlertWithResultSender:resultSender andDetails:[req getDetails]];
    }
}

- (QuakeAlertInternalRequestHandler *)initWithReceiver:(id<QuakeWatchQuakeAlertRequestReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;

    return self;
}
@end

@interface QuakeAlertInternalResponseHandler : NSObject <GolgiInternalInboundResponseHandler>
{
    id<QuakeWatchQuakeAlertResultReceiver> receiver;
}

- (QuakeAlertInternalResponseHandler *)initWithReceiver:(id<QuakeWatchQuakeAlertResultReceiver>)receiver;
@end
@implementation QuakeAlertInternalResponseHandler

- (void)processResponsePayload:(NSString *)payload
{
    QuakeWatch_quakeAlert_rspArg *rsp = [QuakeWatch_quakeAlert_rspArg deserialiseFromString:payload];

    if(rsp == nil){
        GolgiException *golgiException = [[GolgiException alloc]init];

        [golgiException setErrText:@"Corrupt Response"];
        [golgiException setErrType:GOLGI_ERRTYPE_PAYLOAD_MISMATCH];
        [receiver failureWithGolgiException:golgiException];
    }
    else if(rsp.internalSuccess_IsSet && ([rsp getInternalSuccess_] != 0)){
        [receiver success];
    }
    else if(rsp.golgiExceptionIsSet){
        [receiver failureWithGolgiException:[rsp getGolgiException]];
    }
    else{
        NSLog(@"WARNING: result for 'quakeAlert' in Golgi Service 'QuakeWatch' has no expected response fields set!");
    }

}

- (void)processGolgiException:(GolgiException *)golgiException
{
	[receiver failureWithGolgiException:golgiException];
}

- (QuakeAlertInternalResponseHandler *)initWithReceiver:(id<QuakeWatchQuakeAlertResultReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;
    return self;
}

@end



/********************************************************/
/********************************************************/
/********************************************************/


@implementation QuakeWatchSvc
//
// addMe
//
+ (void)sendAddMeUsingResultReceiver:(id<QuakeWatchAddMeResultReceiver>)resultReceiver andDestination:(NSString *)_dst withFilter:(QuakeFilter *)filter
{
    [self sendAddMeUsingResultReceiver:resultReceiver withTransportOptions:nil andDestination:_dst withFilter:filter];
}

//
// addMe with transport options
//
+ (void)sendAddMeUsingResultReceiver:(id<QuakeWatchAddMeResultReceiver>)resultReceiver withTransportOptions:(GolgiTransportOptions *)options andDestination:(NSString *)_dst withFilter:(QuakeFilter *)filter
{
    NSString *_payload;
    QuakeWatch_addMe_reqArg *_reqArg = [[QuakeWatch_addMe_reqArg alloc] init];
    AddMeInternalResponseHandler *_iRspHndlr;
    _iRspHndlr = [AddMeInternalResponseHandler alloc];
    _iRspHndlr = [_iRspHndlr initWithReceiver:resultReceiver];

    [_reqArg setFilter:filter];
    _payload = [_reqArg serialise];

    [Golgi sendRequestPayload:_payload withTransportOptions:options to:_dst withMethod:@"addMe.QuakeWatch" andResponseHandler:_iRspHndlr];

}

+ (void)registerAddMeRequestReceiver:(id<QuakeWatchAddMeRequestReceiver>)requestReceiver
{
    AddMeInternalRequestHandler *reqHandler;
    reqHandler = [AddMeInternalRequestHandler alloc];
    reqHandler = [reqHandler initWithReceiver:requestReceiver];
    [Golgi registerRequestHandler:reqHandler forMethod:@"addMe.QuakeWatch"];
}

//
// removeMe
//
+ (void)sendRemoveMeUsingResultReceiver:(id<QuakeWatchRemoveMeResultReceiver>)resultReceiver andDestination:(NSString *)_dst withGolgiId:(NSString *)golgiId
{
    [self sendRemoveMeUsingResultReceiver:resultReceiver withTransportOptions:nil andDestination:_dst withGolgiId:golgiId];
}

//
// removeMe with transport options
//
+ (void)sendRemoveMeUsingResultReceiver:(id<QuakeWatchRemoveMeResultReceiver>)resultReceiver withTransportOptions:(GolgiTransportOptions *)options andDestination:(NSString *)_dst withGolgiId:(NSString *)golgiId
{
    NSString *_payload;
    QuakeWatch_removeMe_reqArg *_reqArg = [[QuakeWatch_removeMe_reqArg alloc] init];
    RemoveMeInternalResponseHandler *_iRspHndlr;
    _iRspHndlr = [RemoveMeInternalResponseHandler alloc];
    _iRspHndlr = [_iRspHndlr initWithReceiver:resultReceiver];

    [_reqArg setGolgiId:golgiId];
    _payload = [_reqArg serialise];

    [Golgi sendRequestPayload:_payload withTransportOptions:options to:_dst withMethod:@"removeMe.QuakeWatch" andResponseHandler:_iRspHndlr];

}

+ (void)registerRemoveMeRequestReceiver:(id<QuakeWatchRemoveMeRequestReceiver>)requestReceiver
{
    RemoveMeInternalRequestHandler *reqHandler;
    reqHandler = [RemoveMeInternalRequestHandler alloc];
    reqHandler = [reqHandler initWithReceiver:requestReceiver];
    [Golgi registerRequestHandler:reqHandler forMethod:@"removeMe.QuakeWatch"];
}

//
// quakeAlert
//
+ (void)sendQuakeAlertUsingResultReceiver:(id<QuakeWatchQuakeAlertResultReceiver>)resultReceiver andDestination:(NSString *)_dst withDetails:(QuakeDetails *)details
{
    [self sendQuakeAlertUsingResultReceiver:resultReceiver withTransportOptions:nil andDestination:_dst withDetails:details];
}

//
// quakeAlert with transport options
//
+ (void)sendQuakeAlertUsingResultReceiver:(id<QuakeWatchQuakeAlertResultReceiver>)resultReceiver withTransportOptions:(GolgiTransportOptions *)options andDestination:(NSString *)_dst withDetails:(QuakeDetails *)details
{
    NSString *_payload;
    QuakeWatch_quakeAlert_reqArg *_reqArg = [[QuakeWatch_quakeAlert_reqArg alloc] init];
    QuakeAlertInternalResponseHandler *_iRspHndlr;
    _iRspHndlr = [QuakeAlertInternalResponseHandler alloc];
    _iRspHndlr = [_iRspHndlr initWithReceiver:resultReceiver];

    [_reqArg setDetails:details];
    _payload = [_reqArg serialise];

    [Golgi sendRequestPayload:_payload withTransportOptions:options to:_dst withMethod:@"quakeAlert.QuakeWatch" andResponseHandler:_iRspHndlr];

}

+ (void)registerQuakeAlertRequestReceiver:(id<QuakeWatchQuakeAlertRequestReceiver>)requestReceiver
{
    QuakeAlertInternalRequestHandler *reqHandler;
    reqHandler = [QuakeAlertInternalRequestHandler alloc];
    reqHandler = [reqHandler initWithReceiver:requestReceiver];
    [Golgi registerRequestHandler:reqHandler forMethod:@"quakeAlert.QuakeWatch"];
}

@end