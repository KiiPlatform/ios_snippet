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
private let group = KiiGroup(uri: groupUri)
//Add Group Members
private func snippet_1_blocking(){
  let user1 = KiiUser(uri: "put existing user1 uri here")
  let user2 = KiiUser(uri: "put existing user2 uri here")
  
  // Add user1 and user2 to the group
  group.add(user1)
  group.add(user2)
  do {
    try group.saveSynchronous()
  } catch let error as NSError {
    print(error  as Any)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  let user1 = KiiUser(uri: "put existing user1 uri here")
  let user2 = KiiUser(uri: "put existing user2 uri here")
  
  // Add user1 and user2 to the group
  group.add(user1)
  group.add(user2)
  group.save { (group : KiiGroup?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Removing Group Members
private func snippet_2_blocking(){
  let user1 = KiiUser(uri: "put existing user1 uri here")
  let user2 = KiiUser(uri: "put existing user2 uri here")
  
  // Remove user1 and user2 from the group
  group.remove(user1)
  group.remove(user2)
  do {
    try group.saveSynchronous()
  } catch let error as NSError {
    print(error  as Any)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  let user1 = KiiUser(uri: "put existing user1 uri here")
  let user2 = KiiUser(uri: "put existing user2 uri here")
  
  // Remove user1 and user2 from the group
  group.remove(user1)
  group.remove(user2)
  group.save { (group : KiiGroup?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
