//
//  guides_thingifsdk_thingsdk_thing-client_things-securing-data.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/things-securing-data

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
  var success: NSArray?
  var failed: NSArray?

  let acl = thingBucket.bucketACL

  acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionQueryObjects)!)

  acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionCreateObjects)!)

  do {
    try acl.saveSynchronous(&success, didFail: &failed)
  } catch let error as NSError {
    print(error)
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
    let acl = thingBucket.bucketACL

    acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionQueryObjects)!)

    acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionCreateObjects)!)

    acl.save { (acl : KiiACL?, succeeded : [AnyObject]?, failed : [AnyObject]?, error ) -> Void in
      if (error != nil) {
        // Error handling
        return
      }
    }
  }
}

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
  let object = thingBucket.createObject()
  object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
  do {
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  let acl = object.objectACL

  acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.objectActionRead)!)
  var succeeded: NSArray?
  var failed: NSArray?
  do {
    try acl.saveSynchronous(&succeeded, didFail: &failed)
  } catch let error as NSError {
    print(error)
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
    let object = thingBucket.createObject()
    object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
    object.save({ (object : KiiObject?, error ) -> Void in
      if error != nil {
        // Error handling
        return
      }

      let acl = object!.objectACL
      acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.objectActionRead)!)

      acl.save { (acl : KiiACL?, succeeded : [AnyObject]?, failed : [AnyObject]?, error ) -> Void in
        if (error != nil) {
          // Error handling
          return
        }
      }

    })
  }
}
private func snippet_3_blocking(){
  var success: NSArray?
  var failed: NSArray?
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingTopic = thing.topic(withName: "thing_topic")

  do {
    try thingTopic.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  let acl = thingTopic.topicACL

  acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.topicActionSubscribe)!)
  do {
    try acl.saveSynchronous(&success, didFail: &failed)
  } catch let error as NSError {
    print(error)
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
    thingTopic.save({ (thingTopic , error ) -> Void in
      if error != nil {
        // Error handling
        return
      }
      let acl = thingTopic.topicACL

      acl.put(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.topicActionSubscribe)!)
      acl.saveWithBlock({ (acl : KiiACL?, succeeded : [AnyObject]?, failed : [AnyObject]?, error ) -> Void in
        if (error != nil) {
          // Error handling
          return
        }
      })
    })
  }
}

