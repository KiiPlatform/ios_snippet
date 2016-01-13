//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//
#import <KiiSDK/KiiSDK-Bridging-Header.h>
#import <KiiSDK/KiiRandomVariationSampler.h>
@interface KiiGroup(extra)
+ (void)registerGroupWithID:(NSString*)groupID
name:(NSString*)name
members:(NSArray*)members
block:(KiiGroupBlock)block;
+ (KiiGroup*)registerGroupSynchronousWithID:(NSString*)groupID
                                       name:(NSString*)name
                                    members:(NSArray*)members
                                      error:(NSError**)error;
@end
@implementation KiiGroup (extra)

+ (void)registerGroupWithID:(NSString*)groupID
                       name:(NSString*)name
                    members:(NSArray*)members
                      block:(KiiGroupBlock)block{
 //dummy
}
+ (KiiGroup*)registerGroupSynchronousWithID:(NSString*)groupID
                                       name:(NSString*)name
                                    members:(NSArray*)members
                                      error:(NSError**)error{
 return nil;
}
@end