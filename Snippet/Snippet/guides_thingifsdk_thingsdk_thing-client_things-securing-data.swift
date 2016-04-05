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
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingBucket = thing.bucketWithName("thing_bucket")
  var success: NSArray?
  var failed: NSArray?

  let acl = thingBucket.bucketACL

  acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionQueryObjects)!)

  acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionCreateObjects)!)

  do {
    try acl.saveSynchronous(&success, didFail: &failed)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing : KiiThing?, error: NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing!.bucketWithName("thing_bucket")
    let acl = thingBucket.bucketACL

    acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionQueryObjects)!)

    acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionCreateObjects)!)

    acl.saveWithBlock { (acl : KiiACL?, succeeded : [AnyObject]?, failed : [AnyObject]?, error : NSError?) -> Void in
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
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingBucket = thing.bucketWithName("thing_bucket")
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

  acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.ObjectActionRead)!)
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
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing : KiiThing?, error: NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing!.bucketWithName("thing_bucket")
    let object = thingBucket.createObject()
    object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
    object.saveWithBlock({ (object : KiiObject?, error : NSError?) -> Void in
      if error != nil {
        // Error handling
        return
      }

      let acl = object!.objectACL
      acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.ObjectActionRead)!)

      acl.saveWithBlock { (acl : KiiACL?, succeeded : [AnyObject]?, failed : [AnyObject]?, error : NSError?) -> Void in
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
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingTopic = thing.topicWithName("thing_topic")

  do {
    try thingTopic.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  let acl = thingTopic.topicACL

  acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)!)
  do {
    try acl.saveSynchronous(&success, didFail: &failed)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}
private func snippet_3_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing : KiiThing?, error: NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingTopic = thing!.topicWithName("thing_topic")
    thingTopic.saveWithBlock({ (thingTopic : KiiTopic?, error : NSError?) -> Void in
      if error != nil {
        // Error handling
        return
      }
      let acl = thingTopic!.topicACL

      acl.putACLEntry(KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)!)
      acl.saveWithBlock({ (acl : KiiACL?, succeeded : [AnyObject]?, failed : [AnyObject]?, error : NSError?) -> Void in
        if (error != nil) {
          // Error handling
          return
        }
      })
    })
  }
}

