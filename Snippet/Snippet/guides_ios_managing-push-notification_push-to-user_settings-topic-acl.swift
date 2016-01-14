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
  
  var error : NSError?
  group.refreshSynchronous(&error)
  if (error != nil) {
    // Error handling
    return
  }
  
  let topicName = "GroupTopic"
  let topic = group.topicWithName(topicName)
  
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry1 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)
  
  // Set the ACLs on topic
  let acl = topic.topicACL
  acl.putACLEntry(entry1)
  let user : KiiUser?
  
  user = try? KiiUser.findUserByUsernameSynchronous("_I_am_a_supervisor_")
  
  if user == nil {
    //user not found or something happen
    return
  }
  let entry2 = KiiACLEntry(subject: user, andAction: KiiACLAction.TopicActionSubscribe)
  
  let entry3 = KiiACLEntry(subject: user, andAction: KiiACLAction.TopicActionSend)
  acl.putACLEntry(entry2)
  acl.putACLEntry(entry3)
  
  acl.saveSynchronous(&error, didSucceed: &succeeded, didFail: &failed)
  if (error != nil) {
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
  
  group.refreshWithBlock { (group, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
    
    let topicName = "GroupTopic"
    let topic = group.topicWithName(topicName)
    
    // Create ACLs
    let entry1 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)
    
    // Set the ACLs on topic
    let acl = topic.topicACL
    acl.putACLEntry(entry1)
    let user : KiiUser?
    
    user = try? KiiUser.findUserByUsernameSynchronous("_I_am_a_supervisor_")
    
    if user == nil {
      //user not found or something happen
      return
    }
    let entry2 = KiiACLEntry(subject: user, andAction: KiiACLAction.TopicActionSubscribe)
    
    let entry3 = KiiACLEntry(subject: user, andAction: KiiACLAction.TopicActionSend)
    acl.putACLEntry(entry2)
    acl.putACLEntry(entry3)
    
    
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


//user scope topic
private func snippet_2_blocking(){
  let user = KiiUser.currentUser()
  let topicName = "MyTODO"
  let topic = user.topicWithName(topicName)
  
  // Allows group members to subscribe.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  
  var error : NSError?
  group.refreshSynchronous(&error)
  if (error != nil) {
    // Error handling
    return
  }
  
  var succeeded: NSArray?
  var failed: NSArray?
  
  // Create ACLs
  let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.TopicActionSubscribe)
  
  // Set the ACLs on topic
  let acl = topic.topicACL
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
  let user = KiiUser.currentUser()
  let topicName = "MyTODO"
  let topic = user.topicWithName(topicName)
  
  // Allows group members to subscribe.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(URI: groupUri)
  
  group.refreshWithBlock { (group, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
    // Create ACLs
    let entry = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionQueryObjects)
    let entry2 = KiiACLEntry(subject: KiiAnyAuthenticatedUser.aclSubject(), andAction: KiiACLAction.BucketActionCreateObjects)
    
    // Set the ACLs on Bucket
    let acl = topic.topicACL
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
//Getting Topic ACL
private func snippet_3_blocking(){
  let topic = KiiUser.currentUser().topicWithName("MyTODO")
  
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
  let topic = KiiUser.currentUser().topicWithName("MyTODO")
  
  let acl = topic.topicACL
  
  acl.listACLEntriesWithBlock { (retAcl, result, error ) -> Void in
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