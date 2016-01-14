//
//  managing-users_deleting-users.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/deleting-users/

private func snippet_blocking(){
  // Get the currently logged in user.
  let user = KiiUser.currentUser()
  var error : NSError?
  
  user.deleteSynchronous(&error)
  
  if error != nil {
    // Error handling
    return
  }
}

private func snippet_non_blocking(){
  // Get the currently logged in user.
  let user = KiiUser.currentUser()
  
  user.deleteWithBlock { (user, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}