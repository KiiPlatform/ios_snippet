//
//  guides_ios_managing-push-notification_push-to-user_sending-messages.m
//  Snippet3
//
//  Created by syahRiza on 11/24/16.
//  Copyright © 2016 Kii. All rights reserved.
//

#import <Foundation/Foundation.h>
@import KiiSDK;

@interface Snippet : NSObject
{
  NSString* groupUri;

}

@end
@implementation Snippet

-(void) snippet1_blocking{
  NSError *error = nil;

  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  KiiGroup *group = [KiiGroup groupWithURI:groupUri];
  [group refreshSynchronous:&error];
  if (error != nil) {
    // Error handling
    return;
  }

  NSString *topicname = @"GroupTopic";
  KiiTopic *topic = [group topicWithName:topicname];

  // Create APNs message fields
  KiiAPNSFields *apnsFields = [KiiAPNSFields createFields];

  // This sample code assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  //[apnsFields setAlertBody:@"Show message"];

  // Enable the silent push notification by setting "content-available"
  [apnsFields setContentAvailable:@1];

  // Define category
  [apnsFields setCategory:@"MESSAGE_CATEGORY"];

  // Build a push message.
  // FCM and MQTT fields are set, so the message will be sent to devices using FCM or MQTT.
  KiiPushMessage *message = [KiiPushMessage composeMessageWithAPNSFields:apnsFields
                                                            andGCMFields:[KiiGCMFields createFields]
                                                           andMQTTFields:[KiiMQTTFields createFields]];

  NSMutableDictionary *data = [NSMutableDictionary dictionary];
  data[@"str"]=@"str";
  data[@"int"]=[NSNumber numberWithInt:1];
  data[@"bool"]=@YES;
  data[@"double"]=[NSNumber numberWithDouble:1.12];
  message.data = data;

  // Send the message.
  [topic sendMessageSynchronous:message
                      withError:&error];
  
  if (error != nil) {
    // Error handling
    return;
  }
}

-(void) snippet1_non_blocking{
  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  KiiGroup *group = [KiiGroup groupWithURI:groupUri];
  [group refreshWithBlock:^(KiiGroup *group, NSError *error) {
    if (error != nil) {
      // Error handling
      return;
    }

    // Instantiate the group topic.
    NSString *topicname = @"GroupTopic";
    KiiTopic *topic = [group topicWithName:topicname];

    // Create APNs message fields
    KiiAPNSFields *apnsFields = [KiiAPNSFields createFields];

    // This sample code assumes that you are using the silent push notification,
    // so the AlertBody is not set.
    //[apnsFields setAlertBody:@"Show message"];

    // Enable the silent push notification by setting "content-available"
    [apnsFields setContentAvailable:@1];

    // Define category
    [apnsFields setCategory:@"MESSAGE_CATEGORY"];

    // Build a push message.
    // FCM and MQTT fields are set, so the message will be sent to devices using FCM or MQTT.
    KiiPushMessage *message = [KiiPushMessage composeMessageWithAPNSFields:apnsFields
                                                              andGCMFields:[KiiGCMFields createFields]
                                                             andMQTTFields:[KiiMQTTFields createFields]];

    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    data[@"str"]=@"str";
    data[@"int"]=[NSNumber numberWithInt:1];
    data[@"bool"]=@YES;
    data[@"double"]=[NSNumber numberWithDouble:1.12];
    message.data = data;

    // Send the message.
    [topic sendMessage:message
             withBlock:^(KiiTopic *topic, NSError *error) {
               if (error != nil) {
                 // Error handling
                 return;
               }
             }];
  }];
}
/*
 By default, the push message will be sent to all the push notification networks. You can control message delivery by setting a flag upon construction of a KiiPushMessage instance like in the following example:
 */
-(void) snippet1a{

  KiiPushMessage *message;

  // Deliver the push message to Android devices with using FCM only
  KiiGCMFields* gcmFields = [KiiGCMFields createFields];
  [gcmFields setSpecificData:@{@"fcmOnly":@"fcmOnlyData"}];

  message = [KiiPushMessage composeMessageWithAPNSFields:nil andGCMFields:gcmFields andMQTTFields:nil];

  // Deliver the push message to iOS devices with using APNS only
  KiiAPNSFields* apnsFields = [KiiAPNSFields createFields];
  [apnsFields setSpecificData:@{@"apnsOnly":@"apnsOnlyKey"}];

  message = [KiiPushMessage composeMessageWithAPNSFields:apnsFields andGCMFields:nil andMQTTFields:nil];

  // Deliver the push message to Thing devices with using FCM only
  KiiMQTTFields* mqttFields = [KiiMQTTFields createFields];
  [mqttFields setData:@{@"mqttOnly":@"apnsOnlyKey"}];

  message = [KiiPushMessage composeMessageWithAPNSFields:nil andGCMFields:nil andMQTTFields:mqttFields];
}

-(void) snippet2_blocking{
  NSError *error = nil;

  // Instantiate a user-scope topic.
  KiiUser* user = [KiiUser currentUser];
  NSString *topicname = @"MyTODO";
  KiiTopic *topic = [user topicWithName:topicname];

  // Create APNs message fields
  KiiAPNSFields *apnsFields = [KiiAPNSFields createFields];

  // This sample code assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  //[apnsFields setAlertBody:@"Show message"];

  // Enable the silent push notification by setting "content-available"
  [apnsFields setContentAvailable:@1];

  // Define category
  [apnsFields setCategory:@"MESSAGE_CATEGORY"];

  // Build a push message.
  // FCM and MQTT fields are set, so the message will be sent to devices using FCM or MQTT.
  KiiPushMessage *message = [KiiPushMessage composeMessageWithAPNSFields:apnsFields
                                                            andGCMFields:[KiiGCMFields createFields]
                                                           andMQTTFields:[KiiMQTTFields createFields]];

  NSMutableDictionary *data = [NSMutableDictionary dictionary];
  data[@"Item"]=@"Do Something";
  data[@"Done"]=[NSNumber numberWithInt:1];
  message.data = data;

  // Send the push message.
  [topic sendMessageSynchronous:message
                      withError:&error];
  if (error != nil) {
    // Error handling
    return;
  }
}
-(void) snippet2_non_blocking{
  // Instantiate a user-scope topic.
  KiiUser* user = [KiiUser currentUser];
  NSString *topicname = @"MyTODO";
  KiiTopic *topic = [user topicWithName:topicname];

  // Create APNs message fields
  KiiAPNSFields *apnsFields = [KiiAPNSFields createFields];

  // This sample code assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  //[apnsFields setAlertBody:@"Show message"];

  // Enable the silent push notification by setting "content-available"
  [apnsFields setContentAvailable:@1];

  // Define category
  [apnsFields setCategory:@"MESSAGE_CATEGORY"];

  // Build a push message.
  // FCM and MQTT fields are set, so the message will be sent to devices using FCM or MQTT.
  KiiPushMessage *message = [KiiPushMessage composeMessageWithAPNSFields:apnsFields
                                                            andGCMFields:[KiiGCMFields createFields]
                                                           andMQTTFields:[KiiMQTTFields createFields]];

  NSMutableDictionary *data = [NSMutableDictionary dictionary];
  data[@"Item"]=@"Do Something";
  data[@"Done"]=[NSNumber numberWithInt:1];
  message.data = data;

  // Send the push message.
  [topic sendMessage:message
           withBlock:^(KiiTopic *topic, NSError *error) {
             if (error != nil) {
               // Error handling
               return;
             }
           }];
}

/*
 For a user-scope topic, only the user who owns the topic can send a push message to it.

 Let's explore how to do this in the following sample code.
 */
-(void) snippet3_blocking{
  /*skip*/KiiTopic* topic;
  NSError *error = nil;

  // Create APNs message fields
  KiiAPNSFields *apnsFields = [KiiAPNSFields createFields];
  [apnsFields setAlertBody:@"short msg only!"];

  // Create a message.
  NSDictionary* commonData = @{};
  KiiPushMessage *pushMessage = [KiiPushMessage composeMessageWithAPNSFields:apnsFields
                                                                andGCMFields:nil
                                                               andMQTTFields:nil];
  pushMessage.data = commonData;
  
  // Send the push message.
  [topic sendMessageSynchronous:pushMessage
                      withError:&error];
  if (error != nil) {
    // Error handling
    return;
  }
}

//Saving the APNs payload
-(void) snippet3_non_blocking{
  /*skip*/KiiTopic* topic;
  // Create APNs message fields
  KiiAPNSFields *apnsFields = [KiiAPNSFields createFields];
  [apnsFields setAlertBody:@"short msg only!"];

  // Create a message.
  NSDictionary* commonData = @{};
  KiiPushMessage *pushMessage = [KiiPushMessage composeMessageWithAPNSFields:apnsFields
                                                                andGCMFields:nil
                                                               andMQTTFields:nil];
  pushMessage.data = commonData;

  // Send the push message.
  [topic sendMessage:pushMessage
           withBlock:^(KiiTopic *topic, NSError *error) {
             if (error != nil) {
               // Error handling
               return;
             }
           }];
}
/*
-(void) snippet2_blocking{
}
-(void) snippet2_non_blocking{
}
 */
@end
