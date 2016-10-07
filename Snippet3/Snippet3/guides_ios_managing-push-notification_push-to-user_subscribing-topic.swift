//
//  ios_managing-push-notification_push-to-user_subscribing-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/subscribing-topic/
//application-scope topic Subscribing to a topic
private let groupURI = ""
private func snippet_1_blocking(){
  // Instantiates an app-scope topic
  let topicName = "SendingAlert"
  let topic = Kii.topic(withName: topicName)
  do{
    // Subscribing the current user to the topic
    try KiiUser.current()!.pushSubscription().subscribeSynchronous(topic)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_1_non_blocking(){
  // Instantiates an app-scope topic
  let topicName = "SendingAlert"
  let topic = Kii.topic(withName: topicName)
  
  // Subscribing the current user to the topic
  KiiUser.current()!.pushSubscription().subscribe(topic) { (subscription : KiiPushSubscription, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//group-scope topic
private func snippet_2_blocking(){
  // Assume user is already logged in and a topic is already created
  // Instantiates the group
  // (Assume that groupUri has the reference URI of the target group)
  let group = KiiGroup(uri: groupURI)
  
  // Instantiates the group-scope topic
  let topicName = "GroupTopic"
  let topic = group.topic(withName: topicName)

  do{
    // Subscribe the current user to the topic
    // (The current user must be a group member)
    try KiiUser.current()!.pushSubscription().subscribeSynchronous(topic)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_2_non_blocking(){
  // Assume user is already logged in and a topic is already created
  // Instantiates the group
  // (Assume that groupUri has the reference URI of the target group)
  let group = KiiGroup(uri: groupURI)
  
  // Instantiates the group-scope topic
  let topicName = "GroupTopic"
  let topic = group.topic(withName: topicName)
  
  // Subscribe the current user to the topic
  // (The current user must be a group member)
  KiiUser.current()!.pushSubscription().subscribe(topic) { (subscription : KiiPushSubscription, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//user-scope topic
private func snippet_3_blocking(){
  
  // Instantiates a user-scope topic
  let user = KiiUser.current()!
  let topicName = "MyTODO"
  let topic = user.topic(withName: topicName)
  do{
    // Subscribe the current user to the topic
    try KiiUser.current()!.pushSubscription().subscribeSynchronous(topic)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_3_non_blocking(){
  // Instantiates a user-scope topic
  let user = KiiUser.current()!
  let topicName = "MyTODO"
  let topic = user.topic(withName: topicName)
  
  // Subscribe the current user to the topic
  KiiUser.current()!.pushSubscription().subscribe(topic) { (subscription : KiiPushSubscription, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Unsubscribing from a topic
private func snippet_4_blocking(){
  // Assume that the current user is subscribing to the topic
  // (and the target topic has already been instantiated)
  let user = KiiUser.current()!
  let topic = user.topic(withName: "testTopic")
  do{
    try KiiUser.current()!.pushSubscription().unsubscribeSynchronous(topic)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_4_non_blocking(){
  // Assume that the current user is subscribing to the topic
  // (and the target topic has already been instantiated)
  let user = KiiUser.current()!
  let topic = user.topic(withName: "testTopic")
  
  KiiUser.current()!.pushSubscription().unsubscribe(topic) { (subscription : KiiPushSubscription, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
