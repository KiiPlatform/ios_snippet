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
 let user = KiiUser.currentUser()
 
 var error : NSError?
 
 user.updatePasswordSynchronous(&error, from: fromPassword, to: toPassword)
 
 if error != nil {
  //Error Handling
  return
 }
}

private func snippet_1_non_blocking(){
 let fromPassword = "123ABC"
 let toPassword = "myNewPassword"
 let user = KiiUser.currentUser()
 
 user.updatePassword(fromPassword, to: toPassword) { (user, error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
 }
}

//Resetting a Password with an Email Address
private func snippet_2_blocking(){
 var error : NSError?
 
 // the userIdentifier must be a verified phone number OR email address
 KiiUser.resetPasswordSynchronous("user_123456@example.com", notificationMethod: KiiNotificationMethod.EMAIL, error: &error)
 if error != nil {
  //Error Handling
  return
 }
}

private func snippet_2_non_blocking(){
 // the userIdentifier must be a verified phone number OR email address
 KiiUser.resetPassword("user_123456@example.com", notificationMethod: KiiNotificationMethod.EMAIL) { (error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
 }
}

//Resetting a Password with a Phone Number
private func snippet_3_blocking(){
 var error : NSError?
 let phoneNumber = "+81900011100"
 
 // the userIdentifier must be a verified phone number OR email address
 KiiUser.resetPasswordSynchronous(phoneNumber, notificationMethod: KiiNotificationMethod.SMS, error: &error)
 if error != nil {
  //Error Handling
  return
 }
 
}

private func snippet_3_non_blocking(){
 let phoneNumber = "+81900011100"
 // the userIdentifier must be a verified phone number OR email address
 KiiUser.resetPassword(phoneNumber, notificationMethod: KiiNotificationMethod.SMS) { (error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
 }
 
}
