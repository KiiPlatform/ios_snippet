//
//  password.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

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

//Resetting a Password with a Phone Number
private func snippet_4_blocking(){
  let phoneNumber = "+81900011100"
  do {
    try KiiUser.resetPasswordSynchronous(phoneNumber, notificationMethod: KiiNotificationMethod.SMS_PIN)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_4_non_blocking(){
  let phoneNumber = "+81900011100"
  KiiUser.resetPassword(phoneNumber, notificationMethod: KiiNotificationMethod.SMS_PIN) { (error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }

}

//Resetting a Password with a Phone Number
private func snippet_5_blocking(){
  let phoneNumber = "+81900011100"
  let pinCode = "123456"
  let passWord = "new_password_00"
  do {
    try KiiUser.completeResetPasswordSynchronous(phoneNumber, pinCode: pinCode, password: passWord)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_5_non_blocking(){
  let phoneNumber = "+81900011100"
  let pinCode = "123456"
  let passWord = "new_password_00"
  KiiUser.completeResetPassword(phoneNumber, pinCode: pinCode, password: passWord) { (error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }

}




