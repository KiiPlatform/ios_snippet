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
private let group = KiiGroup(URI: groupUri)

private func snippet_blocking(){
  var error : NSError?
  guard let members = try? group.getMemberListSynchronous() as! [KiiUser] else{
    // Error handling
    return
  }

  // iterate through the member list
  for user in members{
    user.refreshSynchronous(&error)
    if error != nil {
      // Error handling
      return
    }
    // do something with the user
    user.describe()
  }
}

private func snippet_non_blocking(){
  group.getMemberListWithBlock { (refGroup, results, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    
    // iterate through the member list
    for user in results as! [KiiUser]{
      user.refreshWithBlock({ (retUser, error ) -> Void in
        if error != nil {
          // Error handling
          return
        }
        // do something with the user
        user.describe()
      })
    }
  }
}