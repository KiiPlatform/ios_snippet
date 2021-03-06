//
//  ios_managing-data_object-storages_scoping.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/scoping/

//Adding a New Object ACL
private func snippet_1_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!
  var succeeded: NSArray?
  var failed: NSArray?

  // Create an acl object to hold our rules
  let acl = object.objectACL

  // Create a rule
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.objectActionRead)!

  // Put the rule in the holder
  acl.put(entry)

  // Save the acl to the object
  do {
    try acl.saveSynchronous(&succeeded, didFail: &failed)
  } catch let error as NSError {
    print(error  as Any)
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }

}
private func snippet_1_non_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create an acl object to hold our rules
  let acl = object.objectACL

  // Create a rule
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.objectActionRead)!

  // Put the rule in the holder
  acl.put(entry)

  // Save the acl to the object
  acl.save { (acl : KiiACL , succeeded : [Any]?, failed : [Any]?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      // Updating at least 1 ACLEntry failed
      // Please check error description and succeeded/failed arrays to see what went wrong...
      return
    }
  }
}
//Disabling an Object ACL
private func snippet_2_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!
  var succeeded: NSArray?
  var failed: NSArray?

  // Create an acl object to hold our rules
  let acl = object.objectACL

  // Create a rule
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.objectActionRead)!
  entry.grant = false

  acl.put(entry)

  // Save the acl to the object
  do {
    try acl.saveSynchronous(&succeeded, didFail: &failed)
  } catch let error as NSError {
    print(error  as Any)
    // Error handling
    // Updating at least 1 ACLEntry failed
    // Please check error description and succeeded/failed arrays to see what went wrong...
    return
  }

}
private func snippet_2_non_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create an acl object to hold our rules
  let acl = object.objectACL

  // Create a rule
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.objectActionRead)!
  entry.grant = false
  acl.put(entry)

  // Save the acl to the object
  acl.save { (acl : KiiACL , succeeded : [Any]?, failed : [Any]?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      // Updating at least 1 ACLEntry failed
      // Please check error description and succeeded/failed arrays to see what went wrong...
      return
    }
  }

}

//Getting Object ACL
private func snippet_3_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create an acl object to hold our rules
  let acl = object.objectACL

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
  let object = KiiObject(uri: "put existing object uri here")!

  // Create an acl object to hold our rules
  let acl = object.objectACL
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

