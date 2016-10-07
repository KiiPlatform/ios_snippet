//
//  managing-users_pseudo-users.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/pseudo-users/

//Creating Pseudo Users
private func snippet_1_blocking(){
  // You can set predefined fields and custom fields.
  let userFields = KiiUserFields()
  userFields.displayName = "Player 1"
  userFields.setObject(NSNumber(value: 12000 as Int), forKey: "HighScore")
  do{
    let user = try KiiUser.registerAsPseudoUserSynchronous(with: userFields)
    // Must save the token.
    // If it's lost the user will not be able to access KiiCloud.
    // If you want to encrypt access token, you need to store to KeyChain.
    UserDefaults.standard.set(user.accessToken, forKey: "token")
  }catch(let error as NSError){
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_1_non_blocking(){
  // You can set predefined fields and custom fields.
  let userFields = KiiUserFields()
  userFields.displayName = "Player 1"
  userFields.setObject(NSNumber(value: 12000 as Int), forKey: "HighScore")
  KiiUser.registerAsPseudoUser(with: userFields) { (user :KiiUser?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Must save the token.
    // If it's lost the user will not be able to access KiiCloud.
    // If you want to encrypt access token, you need to store to KeyChain.
    UserDefaults.standard.set(user!.accessToken, forKey: "token")
  }
}
//Sign in as Pseudo Users
private func snippet_2_blocking(){
  do{
    let token = UserDefaults.standard.string(forKey: "token")!
    let user = try KiiUser.authenticate(withTokenSynchronous: token)
    //dummy just to silence warning
    print(user)
  }catch(let error as NSError){
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_2_non_blocking(){
  let token = UserDefaults.standard.string(forKey: "token")!
  KiiUser.authenticate(withToken: token) { (user :KiiUser?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Becoming a Normal User
private func snippet_3_blocking(){
  let user = KiiUser.current()!
  if !user.isPseudoUser {
    let builder = KiiIdentityDataBuilder()
    builder.userName = "user_123456"
    builder.email = "user_123456@example.com"
    builder.phoneNumber = "+819012345678"
    let identityData = builder.build()!
    do{
      try user.putIdentityDataSynchronous(identityData, userFields: nil, password: "123ABC")
    } catch let error as NSError {
      print(error.description)
      // Error handling
      return
    }

  }
}

private func snippet_3_non_blocking(){
  let user = KiiUser.current()!
  if !user.isPseudoUser {
    let builder = KiiIdentityDataBuilder()
    builder.userName = "user_123456"
    builder.email = "user_123456@example.com"
    builder.phoneNumber = "+819012345678"
    let identityData = builder.build()!
    user.put(identityData, userFields: nil, password: "123ABC") { (user :KiiUser?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    }
  }
}

