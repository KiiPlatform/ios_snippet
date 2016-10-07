//
//  guides_thingifsdk_thingsdk_thing-client_things-push-notification.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/things-push-notification
//Using "Push to App" Notification
private func snippet_1_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingBucket = thing.bucket(withName: "thing_bucket")
  do{
    try KiiUser.current()!.pushSubscription().subscribeSynchronous(thingBucket)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_1_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing!.bucket(withName: "thing_bucket")
    KiiUser.current()!.pushSubscription().subscribe(thingBucket, block: { (subscription : KiiPushSubscription?, error : Error? ) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
//thing subscription
private func snippet_2_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingBucket = thing.bucket(withName: "thing_bucket")
  do{
    try thing.pushSubscription().subscribeSynchronous(thingBucket)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}
private func snippet_2_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing!.bucket(withName: "thing_bucket")
    thing!.pushSubscription().subscribe(thingBucket, block: { (subscription : KiiPushSubscription?, error : Error? ) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
//Using "Push to User" Notification
private func snippet_3_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingTopic = thing.topic(withName: "thing_topic")
  do{
    try KiiUser.current()!.pushSubscription().subscribeSynchronous(thingTopic)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_3_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingTopic = thing!.topic(withName: "thing_topic")
    KiiUser.current()!.pushSubscription().subscribe(thingTopic, block: { (subscription : KiiPushSubscription?, error : Error? ) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
//thing subscription
private func snippet_4_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingTopic = thing.topic(withName: "thing_topic")
  do{
    try thingTopic.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  do{
    try thing.pushSubscription().subscribeSynchronous(thingTopic)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_4_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingTopic = thing!.topic(withName: "thing_topic")
    thingTopic.save({ (thingTopic , error : Error? ) -> Void in
      thing!.pushSubscription().subscribe(thingTopic, block: { (subscription : KiiPushSubscription?, error : Error? ) -> Void in
        if error != nil {
          // Error handling
          return
        }
      })
    })
  }
}
