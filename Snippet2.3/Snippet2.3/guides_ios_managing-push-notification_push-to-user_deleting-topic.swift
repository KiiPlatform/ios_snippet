//
//  ios_managing-push-notification_push-to-user_deleting-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/deleting-topic/
private let topic = KiiUser.currentUser()!.topicWithName("dummy")

private func snippet_blocking(){
  // Assume that "topic" is already instantiated.
  
  do{
    try topic.deleteSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
}

private func snippet_non_blocking(){
  // Assume that "topic" is already instantiated.
  
  topic.deleteWithBlock { (topic : KiiTopic?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
