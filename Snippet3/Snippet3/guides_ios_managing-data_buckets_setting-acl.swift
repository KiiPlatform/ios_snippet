//
//  ios_managing-data_buckets_setting-acl.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/setting-acl/
//Setting Bucket ACL
private func snippet_1_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "my_private")
  
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionQueryObjects)!
  let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionCreateObjects)!
  
  // Set the ACLs on Bucket
  let acl = bucket.bucketACL
  acl.put(entry)
  acl.put(entry2)
  do{
    try acl.saveSynchronous(&succeeded, didFail: &failed)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }

}
private func snippet_1_non_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "my_private")
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionQueryObjects)!
  let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionCreateObjects)!
  
  // Set the ACLs on Bucket
  let acl = bucket.bucketACL
  acl.put(entry)
  acl.put(entry2)

  acl.save { (acl : KiiACL , succeeded : [Any]?, failed : [Any]?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      // Updating at least 1 ACLEntry failed
      // Please check error description and succeeded/failed arrays to see what went wrong...
      return
    }
  }
}

//Disabling Bucket ACL
private func snippet_2_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "my_private")
  
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionQueryObjects)!
  entry.grant = false
  let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionCreateObjects)!
  entry2.grant = false
  
  // Set the ACLs on Bucket
  let acl = bucket.bucketACL
  acl.put(entry)
  acl.put(entry2)
  do{
    try acl.saveSynchronous(&succeeded, didFail: &failed)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }
  
}
private func snippet_2_non_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "my_private")
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionQueryObjects)!
  entry.grant = false
  let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.bucketActionCreateObjects)!
  entry2.grant = false
  
  // Set the ACLs on Bucket
  let acl = bucket.bucketACL
  acl.put(entry)
  acl.put(entry2)
  acl.save { (acl : KiiACL , succeeded : [Any]?, failed : [Any]?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      // Updating at least 1 ACLEntry failed
      // Please check error description and succeeded/failed arrays to see what went wrong...
      return
    }
  }
  
}
//Getting Bucket ACL
private func snippet_3_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "my_private")
  let acl = bucket.bucketACL
  do{
    let aclList = try acl.listACLEntriesSynchronous() as! [KiiACLEntry]
    for entry in aclList{
      let action = entry.action
      let subject = entry.subject
      // Check the ACL entry.
      //dummy just to silence warning
      print(action,subject)
    }
  }catch(let error as NSError){
    // Error handling
    //dummy just to silence warning
    print(error  as Any)
    return
  }
}

private func snippet_3_non_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "my_private")
  let acl = bucket.bucketACL
  acl.listACLEntries { (retAcl : KiiACL, aclList : [Any]?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
    for entry in aclList as! [KiiACLEntry]{
      let action = entry.action
      let subject = entry.subject
      // Check the ACL entry.
      //dummy just to silence warning
      print(action,subject)
    }
  }
}
