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
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    print("Received notification : \(userInfo)")
    
    // Create KiiPushMessage from userInfo.
    let message = KiiPushMessage(fromAPNS: userInfo)
    
    // Get the sender
    if (message.senderUser() != nil) {
      // Obtain KiiUser instance when the sender of the message is a KiiUser.
      // In other cases returns nil.
      let aUser = message.senderUser()
      // Need to execute aUser.refreshWithBlock() before accessing the user.
      print(aUser)
    } else if (message.senderThing() != nil) {
      // Obtain a KiiThing instance when the sender of the message is a KiiThing.
      // In other cases returns nil.
      let aThing = message.senderThing()
      // Need to execute aThing.refreshWithBlock() before accessing the thing.
      print(aThing)
    } else {
      // The message has no sender information
    }
    
    let topicName = message.getValueOf(.TOPIC)
    
    // Show alert message
    message.showAlert(withTitle: topicName)
    
    // Determine the scope
    let scopeType = message.getValueOf( .SCOPE_TYPE)!
    switch(scopeType){
    case "APP_AND_GROUP" :
      // Obtain a KiiGroup instance when the subscribed bucket/topic is a group scope.
      // In other cases returns nil.
      let aGroup = message.eventSourceGroup()
      // Need to execute aGroup.refreshWithBlock() before accessing the group.
      // Do something with the group
      print(aGroup)
      break
    case "APP_AND_USER" :
      // Obtain a KiiUser instance when the subscribed bucket/topic is a user scope.
      // In other cases returns nil.
      let aUser = message.eventSourceUser()
      // Need to execute aUser.refreshWithBlock() before accessing the user.
      // Do something with the user
      print(aUser)
      break
    case "APP_AND_THING" :
      // Obtain a KiiThing instance when the subscribed bucket/topic is a thing scope.
      // In other cases returns nil.
      let aThing = message.eventSourceThing()
      // Need to execute aThing.refreshWithBlock() before accessing the thing.
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
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    print("Received notification : \(userInfo)")
    
    // It's the silent notification
    if userInfo["app"]!["content-available"] as! Int == 1 {
      // Create KiiPushMessage from userInfo.
      let message = KiiPushMessage(fromAPNS: userInfo)
      // Parse the payload.
      // (Please check the snippet in the "Push Notification" section).
      
      // Do something with the notification (save into local database)
      print(message.getValueOf(.SENDER))
      completionHandler(.newData)
      return
    }else{
      completionHandler(.noData)
      return
    }
  }
}


//categorized
private func snippet_3(){
  func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: () -> Void){
    let apps = userInfo["apps"] as! [AnyHashable: Any]
    
    if let category = apps["category"] as! String? , category  == "INVITE_CATEGORY" {
      if identifier == "DECLINE_IDENTIFIER" {
        print("Receive remote notification in background mode : \(userInfo.description)");
        
        // invitation declined, triggered only on background mode.
        // do something in the background
      }else if identifier == "ACCEPT_IDENTIFIER" {
        print("Receive remote notification in foreground mode : \(userInfo.description)");
        
        // invitation accepted, triggered by the time application launched after user tap "Accept" action
      }
    }else {
      // Create KiiPushMessage from userInfo.
      let message = KiiPushMessage(fromAPNS: userInfo)
      // Parse the payload.
      // (Please check the snippet in the "Push Notification" section).
      print(message.getValueOf(.SENDER))
    }
    completionHandler()
  }
}
