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
  let user = KiiUser.current()!
  do{
    try user.deleteSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_non_blocking(){
  let user = KiiUser.current()!
  user.delete { (user :KiiUser, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
