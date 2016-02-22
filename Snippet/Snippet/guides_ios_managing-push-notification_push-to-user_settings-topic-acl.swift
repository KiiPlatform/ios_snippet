//
//  ios_managing-push-notification_push-to-user_setting-topic-acl.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/setting-topic-acl/
private let groupUri = ""
//group scope topic
private func snippet_1_blocking(){
  
  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  do{
    try group.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
  // Instantiate the group topic.
  let topicName = "GroupTopic"
  let topic = group.topicWithName(topicName)
  
  // Get an ACL handler.
  let acl = topic.topicACL
  
  // Allow all application users (authenticated users) to subscribe
  let entry1 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)!
  acl.putACLEntry(entry1)
  
  // Disallow a user to send push message.
  let user : KiiUser?
  user = try? KiiUser.findUserByUsernameSynchronous("_I_am_a_supervisor_")
  if user == nil {
    //user not found or something happen
    return
  }
  let entry2 = KiiACLEntry(subject: user!, andAction: KiiACLAction.TopicActionSubscribe)!
  acl.putACLEntry(entry2)
  let entry3 = KiiACLEntry(subject: user!, andAction: KiiACLAction.TopicActionSend)!
  acl.putACLEntry(entry3)
  
  // Reflect all ACL entries.
  var succeeded: NSArray?
  var failed: NSArray?
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
  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  group.refreshWithBlock { (group, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
    
    // Instantiate the group topic.
    let topicName = "GroupTopic"
    let topic = group!.topicWithName(topicName)
    
    // Get an ACL handler.
    let acl = topic.topicACL
    
    // Allow all application users (authenticated users) to subscribe
    let entry1 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)!
    acl.putACLEntry(entry1)
    
    // Disallow a user to send push message.
    let user : KiiUser?
    user = try? KiiUser.findUserByUsernameSynchronous("_I_am_a_supervisor_")
    if user == nil {
      //user not found or something happen
      return
    }
    let entry2 = KiiACLEntry(subject: user!, andAction: KiiACLAction.TopicActionSubscribe)!
    acl.putACLEntry(entry2)
    let entry3 = KiiACLEntry(subject: user!, andAction: KiiACLAction.TopicActionSend)!
    acl.putACLEntry(entry3)
    
    // Reflect all ACL entries.
    acl.saveWithBlock { (acl , succeeded, failed, error) -> Void in
      if (error != nil) {
        // Error handling
        // Updating at least 1 ACLEntry failed
        // Please check error description and succeeded/failed arrays to see what went wrong...
        return
      }
    }
  }
}


//user scope topic
private func snippet_2_blocking(){
  // Instantiates the already-existing user-scope topic.
  let user = KiiUser.currentUser()!
  let topicName = "MyTODO"
  let topic = user.topicWithName(topicName)
  
  // Get an ACL handler.
  let acl = topic.topicACL
  
  // Allows group members to subscribe.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  
  do{
    try group.refreshSynchronous()
    let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)!
    
    acl.putACLEntry(entry)
    
    // Reflect all ACL entries.
    var succeeded: NSArray?
    var failed: NSArray?
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
  // Instantiates the already-existing user-scope topic.
  let user = KiiUser.currentUser()!
  let topicName = "MyTODO"
  let topic = user.topicWithName(topicName)
  
  // Get an ACL handler.
  let acl = topic.topicACL
  
  // Allows group members to subscribe.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  
  group.refreshWithBlock { (group, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
    // Create ACLs
    let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionQueryObjects)!
    
    acl.putACLEntry(entry)
    
    // Reflect all ACL entries.
    acl.saveWithBlock { (acl , succeeded, failed, error) -> Void in
      if (error != nil) {
        // Error handling
        // Updating at least 1 ACLEntry failed
        // Please check error description and succeeded/failed arrays to see what went wrong...
        return
      }
    }
  }
}
//Getting Topic ACL
private func snippet_3_blocking(){
  let topic = KiiUser.currentUser()!.topicWithName("MyTODO")
  
  let acl = topic.topicACL
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
    print(error)
    return
  }
}

private func snippet_3_non_blocking(){
  let topic = KiiUser.currentUser()!.topicWithName("MyTODO")
  
  let acl = topic.topicACL
  acl.listACLEntriesWithBlock { (retAcl, result, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
    let aclList = result as! [KiiACLEntry]
    
    for entry in aclList{
      let action = entry.action
      let subject = entry.subject
      // Check the ACL entry.
      //dummy just to silence warning
      print(action,subject)
    }
  }
}