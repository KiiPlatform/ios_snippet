//
//  managing-groups_listing-member.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-groups/listing-group-member/
private let groupUri = "groupURI"
private let group = KiiGroup(uri: groupUri)

private func snippet_blocking(){
  
  guard let members = try? group.getMemberListSynchronous() as! [KiiUser] else{
    // Error handling
    return
  }
  
  // iterate through the member list
  for user in members{
    do{
      try user.refreshSynchronous()
    } catch let error as NSError {
      print(error.description)
      // Error handling
      return
    }
    
    // do something with the user
    user.describe()
  }
}

private func snippet_non_blocking(){
  group.getMemberList { (group, members, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let serialQueue = DispatchQueue(label: "com.kii.serial", attributes: [])
    for obj in members! {
      let user = obj as! KiiUser
      serialQueue.async(execute: {
        do{
          // refresh the member using the blocking API
          try user.refreshSynchronous()
        } catch let error as NSError {
          print(error.description)
          // Error handling
          return
        }
        // do something with the user
        user.describe()
      })
    }
  }
}
