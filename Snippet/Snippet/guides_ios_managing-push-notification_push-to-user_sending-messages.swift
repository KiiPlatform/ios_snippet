//
//  ios_managing-push-notification_push-to-user_sending-messages.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/sending-messages/
private let groupUri = ""
//Sending Messages
private func snippet_1_blocking(){
  
  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  do{
    try group.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
  // Instantiate the group topic.
  let topicName = "GroupTopic"
  let topic = group.topicWithName(topicName)
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  
  // This snippet assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  // apnsField.alertBody = "Show Message"
  
  // Build a push message.
  // GCM fields are set nil, so the message will not send to Android devices.
  var dictionary = [NSObject:AnyObject]()
  dictionary["from"] = "Alice"
  dictionary["msgBody"] = "Hi All"
  dictionary["Priority"] = NSNumber(int: 1)
  dictionary["Urgent"] = NSNumber(bool: false)
  dictionary["Weight"] = NSNumber(double: 1.12)
  apnsField.setSpecificData(dictionary)
  
  // Enable the silent push notification by setting "content-available"
  apnsField.contentAvailable = 1
  // Define category (iOS 8)
  apnsField.category = "MESSAGE_CATEGORY"
  
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  
  // Send the message.
  do{
    try topic.sendMessageSynchronous(message)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_1_non_blocking(){
  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  group.refreshWithBlock { (group, error) -> Void in
    
    if error != nil {
      // Error handling
      return
    }
    // Instantiate the group topic.
    let topicName = "GroupTopic"
    let topic = group!.topicWithName(topicName)
    
    // Create APNs message fields
    let apnsField = KiiAPNSFields.createFields()
    
    // This snippet assumes that you are using the silent push notification,
    // so the AlertBody is not set.
    // apnsField.alertBody = "Show Message"
    
    // Build a push message.
    // GCM fields are set nil, so the message will not send to Android devices.
    var dictionary = [NSObject:AnyObject]()
    dictionary["from"] = "Alice"
    dictionary["msgBody"] = "Hi All"
    dictionary["Priority"] = NSNumber(int: 1)
    dictionary["Urgent"] = NSNumber(bool: false)
    dictionary["Weight"] = NSNumber(double: 1.12)
    apnsField.setSpecificData(dictionary)
    
    // Enable the silent push notification by setting "content-available"
    apnsField.contentAvailable = 1
    // Define category (iOS 8)
    apnsField.category = "MESSAGE_CATEGORY"
    
    let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
    
    // Send the message.
    topic.sendMessage(message, withBlock: { (topic, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
  
}
//Let's explore how to do this in the following sample snippet.
private func snippet_2_blocking(){
  
  
  // Instantiate a user-scope topic.
  let user = KiiUser.currentUser()!
  let topicName = "MyToDO"
  let topic = user.topicWithName(topicName)
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  
  // This snippet assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  // apnsField.alertBody = "Show Message"
  
  // Build a push message.
  // GCM fields are set nil, so the message will not send to Android devices.
  var dictionary = [NSObject:AnyObject]()
  dictionary["item"] = "Do Something"
  dictionary["Done"] = NSNumber(int: 1)
  
  apnsField.setSpecificData(dictionary)
  
  // Enable the silent push notification by setting "content-available"
  apnsField.contentAvailable = 1
  // Define category (iOS 8)
  apnsField.category = "MESSAGE_CATEGORY"
  
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  
  // Send the message.
  do{
    try topic.sendMessageSynchronous(message)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_2_non_blocking(){
  // Instantiate a user-scope topic.
  let user = KiiUser.currentUser()!
  let topicName = "MyToDO"
  let topic = user.topicWithName(topicName)
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  
  // This snippet assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  // apnsField.alertBody = "Show Message"
  
  // Build a push message.
  // GCM fields are set nil, so the message will not send to Android devices.
  var dictionary = [NSObject:AnyObject]()
  dictionary["item"] = "Do Something"
  dictionary["Done"] = NSNumber(int: 1)
  apnsField.setSpecificData(dictionary)
  
  // Enable the silent push notification by setting "content-available"
  apnsField.contentAvailable = 1
  // Define category (iOS 8)
  apnsField.category = "MESSAGE_CATEGORY"
  
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  
  // Send the message.
  topic.sendMessage(message, withBlock: { (topic, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
}
private let topic = KiiTopic()
//Saving the APNS payload
//short
private func snippet_3_blocking(){
  
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  apnsField.alertBody = "short message only"
  
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  
  // Send the message.
  do{
    try topic.sendMessageSynchronous(message)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
}
private func snippet_3_non_blocking(){
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  apnsField.alertBody = "short message only"
  
  // Create a message.
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  
  // Send the message.
  topic.sendMessage(message, withBlock: { (topic, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
  
}

//short
private func snippet_4_blocking(){
  
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  apnsField.alertBody = "Looooooooooooooooooong Message!!"
  
  // Create a message.
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  //disable "s" field
  message.sendSender = NSNumber(bool: false)
  //disable "w" field
  message.sendWhen = NSNumber(bool: false)
  //disable "to" field
  message.sendTopicID = NSNumber(bool: false)
  // Disable "sa", "st" and "su" field
  message.sendObjectScope = NSNumber(bool: false)
  
  // Send the message.
  do{
    try topic.sendMessageSynchronous(message)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_4_non_blocking(){
  // Create APNs message fields
  let apnsField = KiiAPNSFields.createFields()
  apnsField.alertBody = "Looooooooooooooooooong Message!!"
  
  // Create a message.
  let message = KiiPushMessage.composeMessageWithAPNSFields(apnsField, andGCMFields: nil)!
  
  //disable "s" field
  message.sendSender = NSNumber(bool: false)
  //disable "w" field
  message.sendWhen = NSNumber(bool: false)
  //disable "to" field
  message.sendTopicID = NSNumber(bool: false)
  // Disable "sa", "st" and "su" field
  message.sendObjectScope = NSNumber(bool: false)
  
  // Send the message.
  topic.sendMessage(message, withBlock: { (topic, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
}