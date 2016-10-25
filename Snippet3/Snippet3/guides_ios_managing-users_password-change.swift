//
//  password.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/password/
//Changing Passwords
private func snippet_1_blocking(){
  let fromPassword = "123ABC"
  let toPassword = "myNewPassword"
  let user = KiiUser.current()!
  do {
    try user.updatePasswordSynchronous(fromPassword, newPassword: toPassword)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
}

private func snippet_1_non_blocking(){
  let fromPassword = "123ABC"
  let toPassword = "myNewPassword"
  let user = KiiUser.current()!

  user.updatePassword(fromPassword, to: toPassword) { (user :KiiUser?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
