//
//  guides_ios_managing-users_sign-up.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/sign-up/

private func snippet_1_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  
  let user = KiiUser(username: username, andPassword: password)

  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  
  let user = KiiUser(username: username, andPassword: password)
  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_2_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  let email = "user_123456@example.com"

  let user = KiiUser(username: username, andEmailAddress: email, andPassword: password)
  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  let email = "user_123456@example.com"
  
  let user = KiiUser(username: username, andEmailAddress: email, andPassword: password)
  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_3_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  let phoneNumber = "+819012345678"
  
  let user = KiiUser(username: username, andPhoneNumber: phoneNumber, andPassword: password)
  user.country = "US"
  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_3_non_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  let phoneNumber = "+819012345678"
  
  let user = KiiUser(username: username, andPhoneNumber: phoneNumber, andPassword: password)
  user.country = "US"
  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_4_blocking(){
  let password = "123ABC"
  let email = "user_123456@example.com"
  
  let user = KiiUser(emailAddress: email, andPassword: password)
  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_4_non_blocking(){
  let password = "123ABC"
  let email = "user_123456@example.com"
  
  let user = KiiUser(emailAddress: email, andPassword: password)
  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_5_blocking(){
  let password = "123ABC"
  let phoneNumber = "+819012345678"
  
  let user = KiiUser(phoneNumber: phoneNumber, andPassword: password)
  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_5_non_blocking(){
  let password = "123ABC"
  let phoneNumber = "+819012345678"
  
  let user = KiiUser(phoneNumber: phoneNumber, andPassword: password)
  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_6_blocking(){
  let user = KiiUser.currentUser()!

  do{
    try user.resendEmailVerificationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_6_non_blocking(){
  let user = KiiUser.currentUser()!
  user.resendEmailVerificationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_7_blocking(){
  let user = KiiUser.currentUser()!
  
  do{
    try user.verifyPhoneNumberSynchronousWithCode("12345")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_7_non_blocking(){
  let user = KiiUser.currentUser()!
  
  user.verifyPhoneNumber("12345", withBlock: { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}

private func snippet_8_blocking(){
  let user = KiiUser.currentUser()!
  do{
    try user.resendPhoneNumberVerificationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_8_non_blocking(){
  let user = KiiUser.currentUser()!
  user.resendPhoneNumberVerificationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
