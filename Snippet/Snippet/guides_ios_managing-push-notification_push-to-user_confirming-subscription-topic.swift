//
//  ios_managing-push-notification_push-to-user_confirming-subscription-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/confirming-subscription-topic/

private func snippet_blocking(){
  // Instantiates the topic in question.
  let topic = Kii.topicWithName("SendingAlert")
  do{
    // Check if the current user is already subscribing to the topic.
    try KiiUser.currentUser().pushSubscription().checkIsSubscribedSynchronous(topic)
  }catch(let error as NSError){
    // topic is not subscribed
    // Error handling
    print("Not subscribed!")
    print(error)
    return
  }
  print("Subscribed!")
}

private func snippet_non_blocking(){
  // Instantiates the topic in question.
  let topic = Kii.topicWithName("SendingAlert")
  
  // Check if the current user is already subscribing to the topic.
  KiiUser.currentUser().pushSubscription().checkIsSubscribed(topic) { (topic, result, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    if (result) {
      print("Subscribed!")
    } else {
      print("Not subscribed!")
    }
  }
  
}
