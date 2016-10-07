//
//  managing-users_retrieving-other-user-s-data.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/retrieving-other-user-s-data/
//Accessing user data with username
private func snippet_1_blocking(){
  let userName = "user_123456"
  let found : KiiUser
  do{
    found = try KiiUser.find(byUsernameSynchronous: userName)
    //dummy just to silence warning
    print(found)
  }catch(let error as NSError){
    // Error handling
    //dummy just to silence warning
    print(error)
    return
  }
}

private func snippet_1_non_blocking(){
  let userName = "user_123456"
  KiiUser.find(byUsername: userName) { (user :KiiUser, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Accessing User Data with Email Address:
private func snippet_2_blocking(){
  let email = "user_123456@example.com"
  let found : KiiUser
  do{
    found = try KiiUser.find(byEmailSynchronous: email)
    //dummy just to silence warning
    print(found)
  }catch(let error as NSError){
    // Error handling
    //dummy just to silence warning
    print(error)
    return
  }
}

private func snippet_2_non_blocking(){
  let email = "user_123456@example.com"
  KiiUser.find(byEmail: email) { (user :KiiUser, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Accessing User Data with Phone Number:
private func snippet_3_blocking(){
  let phone = "+819012345678"
  let found : KiiUser
  do{
    found = try KiiUser.find(byPhoneSynchronous: phone)
    //dummy just to silence warning
    print(found)
  }catch(let error as NSError){
    // Error handling
    //dummy just to silence warning
    print(error)
    return
  }
}

private func snippet_3_non_blocking(){
  let phone = "+819012345678"
  KiiUser.find(byPhone: phone) { (user :KiiUser, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Accessing User Data with URI:
private func snippet_4_blocking(){
  let userUri = "put existing user uri here"
  let userWithURI = KiiUser(uri: userUri)
  
  do{
    try userWithURI.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  let providersDictionary = userWithURI.linkedSocialAccounts
  
  //dummy just to silence warning
  print(providersDictionary)
}

private func snippet_4_non_blocking(){
  let userUri = "put existing user uri here"
  let userWithURI = KiiUser(uri: userUri)
  userWithURI.refresh { (user :KiiUser, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let providersDictionary = userWithURI.linkedSocialAccounts
    //dummy just to silence warning
    print(providersDictionary)
  }
}

//Accessing User Data with user ID:
private func snippet_5_blocking(){
  let userID = "__USER_ID_"
  let userWithID = KiiUser(uri: userID)
  
  do{
    try userWithID.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  if userWithID.isLinked(withSocialProvider: .Facebook) {
    // User is linked to the Facebook account.
  }
  if userWithID.isLinked(withSocialProvider: .Twitter){
    // User is linked to the Twitter account.
  }
  // check whether the user is disabled.
  let disabled = userWithID.disabled
  print(disabled)
}

private func snippet_5_non_blocking(){
  let userID = "__USER_ID_"
  let userWithID = KiiUser(uri: userID)
  userWithID.refresh { (user :KiiUser, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    if userWithID.isLinked(withSocialProvider: .Facebook) {
      // User is linked to the Facebook account.
    }
    if userWithID.isLinked(withSocialProvider: .Twitter){
      // User is linked to the Twitter account.
    }
    // check whether the user is disabled.
    let disabled = userWithID.disabled
    print(disabled)
  }
}
