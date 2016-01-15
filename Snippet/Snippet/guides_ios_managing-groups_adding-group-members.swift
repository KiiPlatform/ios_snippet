//
//  managing-groups_adding-group-members.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path /guides/ios/managing-groups/adding-group-members/
private let groupUri = "groupURI"
private let group = KiiGroup(URI: groupUri)
//Add Group Members
private func snippet_1_blocking(){
  let user1 = KiiUser(URI: "put existing user1 uri here")
  let user2 = KiiUser(URI: "put existing user2 uri here")
  
  // Add user1 and user2 to the group
  var error : NSError?
  group.addUser(user1)
  group.addUser(user2)
  group.saveSynchronous(&error)
  
  if error != nil {
    // Error handling
    return
  }
}

private func snippet_1_non_blocking(){
  let user1 = KiiUser(URI: "put existing user1 uri here")
  let user2 = KiiUser(URI: "put existing user2 uri here")
  
  // Add user1 and user2 to the group
  group.addUser(user1)
  group.addUser(user2)
  group.saveWithBlock { (refGroup, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Removing Group Members
private func snippet_2_blocking(){
  let user1 = KiiUser(URI: "put existing user1 uri here")
  let user2 = KiiUser(URI: "put existing user2 uri here")
  
  // Remove user1 and user2 from the group
  var error : NSError?
  group.removeUser(user1)
  group.removeUser(user2)
  group.saveSynchronous(&error)
  
  if error != nil {
    // Error handling
    return
  }
}

private func snippet_2_non_blocking(){
  let user1 = KiiUser(URI: "put existing user1 uri here")
  let user2 = KiiUser(URI: "put existing user2 uri here")
  
  // Remove user1 and user2 from the group
  group.removeUser(user1)
  group.removeUser(user2)
  group.saveWithBlock { (refGroup, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}