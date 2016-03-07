//
//  ios_managing-push-notification_push-to-user_creating-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/creating-topic/

//Creating a Group-scope Topic
private func snippet_1_blocking(){
  // Create a group
  let group = KiiGroup(name: "group name")
  
  do{
    try group.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  // Create instance of group scope topic.
  // (assume that the current user is a member of the group)
  let topicName = "GroupTopic"
  let topic = group.topicWithName(topicName)
  
  // Save the topic to Kii Cloud
  do{
    try topic.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_1_non_blocking(){
  // Create a group
  let group = KiiGroup(name: "group name")
  group.saveWithBlock { (group : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    
    // Create instance of group scope topic.
    // (assume that the current user is a member of the group)
    let topicName = "GroupTopic"
    let topic = group!.topicWithName(topicName)
    
    // Save the topic to Kii Cloud
    topic.saveWithBlock { (topic : KiiTopic?, error : NSError?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    }
  }
}

//Creating a User-scope Topic
private func snippet_2_blocking(){
  
  
  // Create a user-scope topic
  let user = KiiUser.currentUser()!
  let topicName = "MyTODO"
  let topic = user.topicWithName(topicName)
  
  // Save the topic to Kii Cloud
  do{
    try topic.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
}
private func snippet_2_non_blocking(){
  // Create a user-scope topic
  let user = KiiUser.currentUser()!
  let topicName = "MyTODO"
  let topic = user.topicWithName(topicName)
  
  // Save the topic to Kii Cloud
  topic.saveWithBlock { (topic : KiiTopic?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
  
}
