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
  let topic = Kii.topicWithName("SendingAlert")
  do{
    try KiiUser.currentUser().pushSubscription().checkIsSubscribedSynchronous(topic)
  }catch(let error as NSError){
    // topic is not subscribed
    // Error handling
    print(error)
    return
  }
}

private func snippet_non_blocking(){
  let topic = Kii.topicWithName("SendingAlert")
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
