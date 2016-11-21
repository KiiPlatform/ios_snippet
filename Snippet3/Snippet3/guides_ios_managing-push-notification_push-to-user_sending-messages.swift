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
  let group = KiiGroup(uri: groupUri)
  do{
    try group.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
  // Instantiate the group topic.
  let topicName = "GroupTopic"
  let topic = group.topic(withName: topicName)
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.create()
  
  // This snippet assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  // apnsField.alertBody = "Show Message"
  
  // Build a push message.
  // GCM fields are set nil, so the message will not send to Android devices.
  var dictionary = [AnyHashable: Any]()
  dictionary["from"] = "Alice"
  dictionary["msgBody"] = "Hi All"
  dictionary["Priority"] = NSNumber(value: 1 as Int32)
  dictionary["Urgent"] = NSNumber(value: false as Bool)
  dictionary["Weight"] = NSNumber(value: 1.12 as Double)
  apnsField.setSpecificData(dictionary)
  
  // Enable the silent push notification by setting "content-available"
  apnsField.contentAvailable = 1
  // Define category (iOS 8)
  apnsField.category = "MESSAGE_CATEGORY"
  
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  
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
  let group = KiiGroup(uri: groupUri)
  group.refresh { (group : KiiGroup?, error : Error?) -> Void in
    
    if error != nil {
      // Error handling
      return
    }
    // Instantiate the group topic.
    let topicName = "GroupTopic"
    let topic = group!.topic(withName: topicName)
    
    // Create APNs message fields
    let apnsField = KiiAPNSFields.create()
    
    // This snippet assumes that you are using the silent push notification,
    // so the AlertBody is not set.
    // apnsField.alertBody = "Show Message"
    
    // Build a push message.
    // GCM fields are set nil, so the message will not send to Android devices.
    var dictionary = [AnyHashable: Any]()
    dictionary["from"] = "Alice"
    dictionary["msgBody"] = "Hi All"
    dictionary["Priority"] = NSNumber(value: 1 as Int32)
    dictionary["Urgent"] = NSNumber(value: false as Bool)
    dictionary["Weight"] = NSNumber(value: 1.12 as Double)
    apnsField.setSpecificData(dictionary)
    
    // Enable the silent push notification by setting "content-available"
    apnsField.contentAvailable = 1
    // Define category (iOS 8)
    apnsField.category = "MESSAGE_CATEGORY"
    
    let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
    
    // Send the message.
    topic.send(message, with: { (topic , error : Error?) -> Void in
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
  let user = KiiUser.current()!
  let topicName = "MyToDO"
  let topic = user.topic(withName: topicName)
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.create()
  
  // This snippet assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  // apnsField.alertBody = "Show Message"
  
  // Build a push message.
  // GCM fields are set nil, so the message will not send to Android devices.
  var dictionary = [AnyHashable: Any]()
  dictionary["item"] = "Do Something"
  dictionary["Done"] = NSNumber(value: 1 as Int32)
  
  apnsField.setSpecificData(dictionary)
  
  // Enable the silent push notification by setting "content-available"
  apnsField.contentAvailable = 1
  // Define category (iOS 8)
  apnsField.category = "MESSAGE_CATEGORY"
  
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  
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
  let user = KiiUser.current()!
  let topicName = "MyToDO"
  let topic = user.topic(withName: topicName)
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.create()
  
  // This snippet assumes that you are using the silent push notification,
  // so the AlertBody is not set.
  // apnsField.alertBody = "Show Message"
  
  // Build a push message.
  // GCM fields are set nil, so the message will not send to Android devices.
  var dictionary = [AnyHashable: Any]()
  dictionary["item"] = "Do Something"
  dictionary["Done"] = NSNumber(value: 1 as Int32)
  apnsField.setSpecificData(dictionary)
  
  // Enable the silent push notification by setting "content-available"
  apnsField.contentAvailable = 1
  // Define category (iOS 8)
  apnsField.category = "MESSAGE_CATEGORY"
  
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  
  // Send the message.
  topic.send(message, with: { (topic , error : Error?) -> Void in
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
  let apnsField = KiiAPNSFields.create()
  apnsField.alertBody = "short message only"
  
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  
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
  let apnsField = KiiAPNSFields.create()
  apnsField.alertBody = "short message only"
  
  // Create a message.
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  
  // Send the message.
  topic.send(message, with: { (topic , error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
  
}

//short
private func snippet_4_blocking(){
  
  
  // Create APNs message fields
  let apnsField = KiiAPNSFields.create()
  apnsField.alertBody = "Looooooooooooooooooong Message!!"
  
  // Create a message.
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  //disable "s" field
  message.sendSender = NSNumber(value: false as Bool)
  //disable "w" field
  message.sendWhen = NSNumber(value: false as Bool)
  //disable "to" field
  message.sendTopicID = NSNumber(value: false as Bool)
  // Disable "sa", "st" and "su" field
  message.sendObjectScope = NSNumber(value: false as Bool)
  
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
  let apnsField = KiiAPNSFields.create()
  apnsField.alertBody = "Looooooooooooooooooong Message!!"
  
  // Create a message.
  let message = KiiPushMessage.composeMessage(with: apnsField, andGCMFields: nil)
  
  //disable "s" field
  message.sendSender = NSNumber(value: false as Bool)
  //disable "w" field
  message.sendWhen = NSNumber(value: false as Bool)
  //disable "to" field
  message.sendTopicID = NSNumber(value: false as Bool)
  // Disable "sa", "st" and "su" field
  message.sendObjectScope = NSNumber(value: false as Bool)
  
  // Send the message.
  topic.send(message, with: { (topic , error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
}
