//
//  ios_managing-push-notification_direct-push.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/direct-push/
private func snippet(){
 //snippet starts here
 func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
  print("Received notification : \(userInfo)")
  
  // Create KiiPushMessage from userInfo.
  let message = KiiPushMessage(fromAPNS: userInfo)
  // Get Topic string using getValueOfKiiMessageField. "KiiMessage_TOPIC" is enum that is defined in KiiMessageField.
  let title = message.getValueOfKiiMessageField(.TOPIC)
  // Show alert message
  message.showMessageAlertWithTitle(title)
  
 }
}