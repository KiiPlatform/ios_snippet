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
  var error : NSError?
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionQueryObjects)
  entry.grant = false
  let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionCreateObjects)
  entry2.grant = false
  // Set the ACLs on Bucket
  let acl = thingBucket.bucketACL
  acl.putACLEntry(entry)
  acl.putACLEntry(entry2)
  
  acl.saveSynchronous(&error, didSucceed: &succeeded, didFail: &failed)
  if (error != nil) {
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }
  
}

private func snippet_1_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing.bucketWithName("thing_bucket")
    // Create ACLs
    let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionQueryObjects)
    entry.grant = false
    let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionCreateObjects)
    entry2.grant = false
    // Set the ACLs on Bucket
    let acl = thingBucket.bucketACL
    acl.putACLEntry(entry)
    acl.putACLEntry(entry2)
    acl.saveWithBlock { (acl , succeeded, failed, error ) -> Void in
      if (error != nil) {
        // Error handling
        // Updating at least 1 ACLEntry failed
        // Please check error description and succeeded/failed arrays to see what went wrong...
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
  var error : NSError?
  object.saveSynchronous(&error)
  if error != nil {
    // Error handling
    return
  }
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.ObjectActionRead)
  
  // Set the ACLs on Object
  let acl = object.objectACL
  acl.putACLEntry(entry)
  
  acl.saveSynchronous(&error, didSucceed: &succeeded, didFail: &failed)
  if (error != nil) {
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }
  
}

private func snippet_2_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing.bucketWithName("thing_bucket")
    let object = thingBucket.createObject()
    object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
    object.saveWithBlock({ (object , error ) -> Void in
      if error != nil {
        // Error handling
        return
      }
      // Create ACLs
      let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.ObjectActionRead)
      
      // Set the ACLs on Object
      let acl = object.objectACL
      acl.putACLEntry(entry)
      
      acl.saveWithBlock { (acl , succeeded, failed, error ) -> Void in
        if (error != nil) {
          // Error handling
          // Updating at least 1 ACLEntry failed
          // Please check error description and succeeded/failed arrays to see what went wrong...
          return
        }
      }
      
    })
  }
}
private func snippet_3_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingTopic = thing.topicWithName("thing_topic")
  var error: NSError?
  KiiUser.currentUser().pushSubscription().subscribeSynchronous(thingTopic, error: &error)
  if error != nil {
    // Error handling
    return
  }
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)
  
  // Set the ACLs on topic
  let acl = thingTopic.topicACL
  acl.putACLEntry(entry)
  
  acl.saveSynchronous(&error, didSucceed: &succeeded, didFail: &failed)
  if (error != nil) {
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }
  
}
private func snippet_3_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingTopic = thing.topicWithName("thing_topic")
    KiiUser.currentUser().pushSubscription().subscribe(thingTopic, block: { (subscription, error ) -> Void in
      if error != nil {
        // Error handling
        return
      }
      // Create ACLs
      let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)
      
      // Set the ACLs on topic
      let acl = thingTopic.topicACL
      acl.putACLEntry(entry)
      acl.saveWithBlock({ (acl , succeded, failed, error ) -> Void in
        if (error != nil) {
          // Error handling
          // Updating at least 1 ACLEntry failed
          // Please check error description and succeeded/failed arrays to see what went wrong...
          return
        }
      })
    })
  }
}

