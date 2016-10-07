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

//Resetting a Password with an Email Address
private func snippet_2_blocking(){
  do {
    // the userIdentifier must be a verified phone number OR email address
    try KiiUser.resetPasswordSynchronous("user_123456@example.com", notificationMethod: KiiNotificationMethod.EMAIL)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  // the userIdentifier must be a verified phone number OR email address
  KiiUser.resetPassword("user_123456@example.com", notificationMethod: KiiNotificationMethod.EMAIL) { (error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Resetting a Password with a Phone Number
private func snippet_3_blocking(){
  let phoneNumber = "+81900011100"
  do {
    try KiiUser.resetPasswordSynchronous(phoneNumber, notificationMethod: KiiNotificationMethod.SMS)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
  
}

private func snippet_3_non_blocking(){
  let phoneNumber = "+81900011100"
  KiiUser.resetPassword(phoneNumber, notificationMethod: KiiNotificationMethod.SMS) { (error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
  
}
