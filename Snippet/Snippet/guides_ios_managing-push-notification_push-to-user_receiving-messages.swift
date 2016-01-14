//
//  ios_managing-push-notification_push-to-user_receiving-messages.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/receiving-messages/
private func snippet_1(){
  //snippet starts here
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    print("Received notification : \(userInfo)")
    
    // Create KiiPushMessage from userInfo.
    let message = KiiPushMessage(fromAPNS: userInfo)
    
    // Get the sender
    if (message.senderUser() != nil) {
      // Obtain KiiUser instance when the sender of the message is a KiiUser.
      // In other cases returns nil.
      let aUser = message.senderUser()
      print(aUser)
    } else if (message.senderThing() != nil) {
      // Obtain a KiiThing instance when the sender of the message is a KiiThing.
      // In other cases returns nil.
      let aThing = message.senderThing()
      print(aThing)
    } else {
      // The message has no sender information
    }
    
    let topicName = message.getValueOfKiiMessageField(.TOPIC)
    
    // Show alert message
    message.showMessageAlertWithTitle(topicName)
    
    // Determine the scope
    let scopeType = message.getValueOfKiiMessageField( .SCOPE_TYPE)
    switch(scopeType){
    case "APP_AND_GROUP" :
      // Obtain a KiiGroup instance when the subscribed bucket/topic is a group scope.
      // In other cases returns nil.
      let aGroup = message.eventSourceGroup()
      // Do something with the group
      print(aGroup)
      break
    case "APP_AND_USER" :
      // Obtain a KiiUser instance when the subscribed bucket/topic is a user scope.
      // In other cases returns nil.
      let aUser = message.eventSourceUser()
      // Do something with the user
      print(aUser)
      break
    case "APP_AND_THING" :
      // Obtain a KiiThing instance when the subscribed bucket/topic is a thing scope.
      // In other cases returns nil.
      let aThing = message.eventSourceThing()
      // Do something with the thing
      print(aThing)
      break
      
    default:
      // The subscribed bucket/topic is an application scope.
      break;
    }
    
    
  }
}
//silent
private func snippet_2(){
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    print("Received notification : \(userInfo)")
    
    if userInfo["app"]!["content-available"] as! Int == 1 {
      // Create KiiPushMessage from userInfo.
      let message = KiiPushMessage(fromAPNS: userInfo)
      // Parse the payload.
      // (Please check the snippet in the "Push Notification" section).
      
      // Do something with the notification (save into local database)
      print(message.getValueOfKiiMessageField(.SENDER))
      
      completionHandler(.NewData)
      
    }else{
      completionHandler(.NoData)
    }
  }
}


//categorized
private func snippet_3(){
  func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void){
    
    let apps = userInfo["apps"] as! [NSObject:AnyObject]
    
    if let category = apps["category"] as! String? where category  == "INVITE_CATEGORY" {
      if identifier == "DECLINE_IDENTIFIER" {
        print("Receive remote notification in background mode : \(userInfo.description)");
        
        // invitation declined, triggered only on background mode.
        // do something in the background
      }else if identifier == "ACCEPT_IDENTIFIER" {
        // invitation accepted, triggered by the time application launched after user tap "Accept" action
        print("Receive remote notification in foreground mode : \(userInfo.description)");
      }
    }else {
      // Create KiiPushMessage from userInfo.
      let message = KiiPushMessage(fromAPNS: userInfo)
      // Parse the payload.
      // (Please check the snippet in the "Push Notification" section).
      
      // Do something with the notification (save into local database)
      print(message.getValueOfKiiMessageField(.SENDER))
      
      
    }
    completionHandler()
  }
}