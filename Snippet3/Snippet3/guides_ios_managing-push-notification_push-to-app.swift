//
//  ios_managing-push-notification_push-to-app.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-app/

//Subscribe to a Kii Bucket
private func snippet_1_blocking(){
  // Instantiates a bucket
  let bucket = Kii.bucket(withName: "test_bucket")
  let obj1 = bucket.createObject()

  do{
    try obj1.saveSynchronous()
    try KiiUser.current()!.pushSubscription().subscribeSynchronous(bucket)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_1_non_blocking(){
  // Instantiates a bucket
  let bucket = Kii.bucket(withName: "test_bucket")
  let obj1 = bucket.createObject()

  obj1.save { (retObject : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    KiiUser.current()!.pushSubscription().subscribe(bucket, block: { (subscription : KiiPushSubscription, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}

//Check if Subscribed to a Kii Bucket
private func snippet_2_blocking(){
  // Instantiates a bucket
  let bucket = Kii.bucket(withName: "test_bucket")
  do{
    try KiiUser.current()!.pushSubscription().checkIsSubscribedSynchronous(bucket)
  }catch(let error as NSError){
    // Error handling
    print("Not subscribed!");
    print(error  as Any)
  }
  print("Subscribed!");
}
private func snippet_2_non_blocking(){
  // Instantiates a bucket
  let bucket = Kii.bucket(withName: "test_bucket")
  KiiUser.current()!.pushSubscription().checkIsSubscribed(bucket) { (retBucket : KiiSubscribable , result : Bool, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    if (result) {
      print("Subscribed!");
    } else {
      print("Not subscribed!");
    }
  }
}
//Receive a "Push to App" Notification
private func snippet_3(){
  class AppDelegate : NSObject,UIAlertViewDelegate{
    //snippet starts here
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      print("Received notification : \(userInfo)")

      // Create KiiPushMessage from userInfo.
      let message = KiiPushMessage(fromAPNS: userInfo)

      // Get the object
      if (message.containsKiiObject()) {
        let anObject = message.eventSourceObject()
        // Do something with the object
        print(anObject  as Any)
      }

      // Get the bucket
      if (message.containsKiiBucket()) {
        let aBucket = message.eventSourceBucket();
        // Do something with the bucket
        print(aBucket  as Any)
      }

      // Get the sender
      if (message.senderUser() != nil) {
        // Obtain KiiUser instance when the sender of the message is a KiiUser.
        // In other cases returns nil.
        let aUser = message.senderUser()
        // Need to execute aUser.refreshWithBlock() before accessing the user.
        print(aUser  as Any)
      } else if (message.senderThing() != nil) {
        // Obtain a KiiThing instance when the sender of the message is a KiiThing.
        // In other cases returns nil.
        let aThing = message.senderThing()
        // Need to execute aThing.refreshWithBlock() before accessing the thing.
        print(aThing  as Any)
      } else {
        // The message has no sender information
      }

      // Determine the scope
      let scopeType = message.getValueOf( .SCOPE_TYPE)!
      switch(scopeType){
      case "APP_AND_GROUP" :
        // Obtain a KiiGroup instance when the subscribed bucket/topic is a group scope.
        // In other cases returns nil.
        let aGroup = message.eventSourceGroup()
        // Do something with the group
        // Need to execute aGroup.refreshWithBlock() before accessing the group.
        print(aGroup  as Any)
        break
      case "APP_AND_USER" :
        // Obtain a KiiUser instance when the subscribed bucket/topic is a user scope.
        // In other cases returns nil.
        let aUser = message.eventSourceUser()
        // Do something with the user
        // Need to execute aUser.refreshWithBlock() before accessing the user.
        print(aUser  as Any)
        break
      case "APP_AND_THING" :
        // Obtain a KiiThing instance when the subscribed bucket/topic is a thing scope.
        // In other cases returns nil.
        let aThing = message.eventSourceThing()
        // Do something with the thing
        // Need to execute aThing.refreshWithBlock() before accessing the thing.
        print(aThing  as Any)
        break

      default:
        // The subscribed bucket/topic is an application scope.
        break;
      }
      // Get bucket string using getValueOfKiiMessageField.
      // "KiiMessage_BUCKET_ID" is an enum that is defined in KiiMessageField.
      let title = message.getValueOf(.BUCKET_ID)

      // Get type string using getValueOfKiiMessageField.
      // "KiiMessage_TYPE" is enum that is defined in KiiMessageField.
      let description = message.getValueOf(.TYPE)

      // Show Alert message
      let alert = UIAlertView(title: title, message: description, delegate: self, cancelButtonTitle: "OK")
      alert.show()

    }
    //snippet ends here
  }
}

