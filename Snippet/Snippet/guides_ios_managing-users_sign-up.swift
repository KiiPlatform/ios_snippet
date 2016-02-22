//
//  guides_ios_managing-users_sign-up.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/sign-up/

private func sign_up_1(){
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

private func sign_up_1_asynch(){
  let username = "user_123456"
  let password = "123ABC"
  
  let user = KiiUser(username: username, andPassword: password)
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func sign_up_2_synch(){
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

private func sign_up_2_asynch(){
  let username = "user_123456"
  let password = "123ABC"
  let email = "user_123456@example.com"
  
  let user = KiiUser(username: username, andEmailAddress: email, andPassword: password)
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func sign_up_3_synch(){
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

private func sign_up_3_asynch(){
  let username = "user_123456"
  let password = "123ABC"
  let phoneNumber = "+819012345678"
  
  let user = KiiUser(username: username, andPhoneNumber: phoneNumber, andPassword: password)
  user.country = "US"
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
private func sign_up_4_synch(){
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

private func sign_up_4_asynch(){
  let password = "123ABC"
  let email = "user_123456@example.com"
  
  let user = KiiUser(emailAddress: email, andPassword: password)
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func sign_up_5_synch(){
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

private func sign_up_5_asynch(){
  let password = "123ABC"
  let phoneNumber = "+819012345678"
  
  let user = KiiUser(phoneNumber: phoneNumber, andPassword: password)
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func sign_up_verify1_synch(){
  let user = KiiUser.currentUser()!

  do{
    try user.resendEmailVerificationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func sign_up_verify1_asynch(){
  let user = KiiUser.currentUser()!
  user.resendEmailVerificationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func sign_up_verify2_synch(){
  let user = KiiUser.currentUser()!
  
  do{
    try user.verifyPhoneNumberSynchronousWithCode("12345")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func sign_up_verify2_asynch(){
  let user = KiiUser.currentUser()!
  
  user.verifyPhoneNumber("12345", withBlock: { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}
private func sign_up_verify3_synch(){
  let user = KiiUser.currentUser()!
  do{
    try user.resendPhoneNumberVerificationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func sign_up_verify3_asynch(){
  let user = KiiUser.currentUser()!
  user.resendPhoneNumberVerificationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
