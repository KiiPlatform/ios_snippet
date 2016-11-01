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
  user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
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
  user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
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
  user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
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
  user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
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
  user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_6_blocking(){
  let user = KiiUser.current()!

  do{
    try user.resendEmailVerificationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_6a_blocking(){
  let identifier = "09012345678"
  let password = "123ABC"

  let builder = KiiUserBuilder(identifier: identifier, password: password)
  if (builder == nil) {
    // Fail to instantiate KiiUserBuilder.
    // Error handling
    return
  }

  // You can set user name, email address, global phone number and
  // local phone number to builder with proper settter if you want.
  let username = "user_123456";
  builder!.setUsername(username)

  // Build a KiiUser instance.
  let user = builder!.build()

  // If you set local phone number as identifier, you need to set
  // country code to the KiiUser instance.
  let country = "JP"
  user.country = country

  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_6a_non_blocking(){
  let identifier = "09012345678"
  let password = "123ABC"

  let builder = KiiUserBuilder(identifier: identifier, password: password)
  if (builder == nil) {
    // Fail to instantiate KiiUserBuilder.
    // Error handling
    return
  }

  // You can set user name, email address, global phone number and
  // local phone number to builder with proper settter if you want.
  let username = "user_123456";
  builder!.setUsername(username)

  // Build a KiiUser instance.
  let user = builder!.build()

  // If you set local phone number as identifier, you need to set
  // country code to the KiiUser instance.
  let country = "JP"
  user.country = country

  user.performRegistration { (user: KiiUser?, error: Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_6_non_blocking(){
  let user = KiiUser.current()!
  user.resendEmailVerification { (user :KiiUser?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_7_blocking(){
  let user = KiiUser.current()!
  
  do{
    try user.verifyPhoneNumberSynchronous("12345")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_7_non_blocking(){
  let user = KiiUser.current()!
  
  user.verifyPhoneNumber("12345", with: { (user :KiiUser?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}

private func snippet_8_blocking(){
  let user = KiiUser.current()!
  do{
    try user.resendPhoneNumberVerificationSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_8_non_blocking(){
  let user = KiiUser.current()!
  user.resendPhoneNumberVerification { (user :KiiUser?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_9_blocking(){
    let username = "user_123456"
    let password = "123ABC"

    let user = KiiUser(username: username, andPassword: password)
    user.locale = LocaleContainer()

    do{
        try user.performRegistrationSynchronous()
    } catch let error as NSError {
        print(error.description)
        // Error handling
        return
    }

}

private func snippet_9_non_blocking(){
    let username = "user_123456"
    let password = "123ABC"

    let user = KiiUser(username: username, andPassword: password)
    user.locale = LocaleContainer()

    user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
        if (error != nil) {
            // Error handling
            return
        }
    }
}

