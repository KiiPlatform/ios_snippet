//
//  ios_managing-push-notification_push-to-user_checking-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/checking-topic/

private let topic = KiiUser.currentUser().topicWithName("dummy")

private func snippet_blocking(){
  // Assume that "topic" is already instantiated.
  do {
    try topic.checkIfExistsSynchronous()
  } catch {
    print("Topic is not exists!")
    // topic does not exist
    return
  }
  
  print("Topic is exists!")
}
private func snippet_non_blocking(){
  // Assume that "topic" is already instantiated.
  topic.checkIfExists { (topic, isExists, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    if (isExists) {
      print("Topic is exists!")
    } else {
      print("Topic is not exists!")
    }
  }
}
