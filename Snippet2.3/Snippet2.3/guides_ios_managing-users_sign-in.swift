//
//  guides_ios_managing-users_sign-in.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/sign-in/

private func snippet_1_blocking(){
  let username = "user123456"
  let password = "123ABC"

  do{
    try KiiUser.authenticateSynchronous(username, withPassword: password)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_1_non_blocking(){
  let username = "user123456"
  let password = "123ABC"

  KiiUser.authenticate(username, withPassword: password) { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_2(){
  // Assume user is signed-in

  // Method #1: Retrieve access token with the accessToken
  let token1 = KiiUser.currentUser()!.accessToken

  // Method #2: Retrieve access token with acceessTokenDictonary
  let dictionary = KiiUser.currentUser()!.accessTokenDictionary()!
  let token2 = dictionary["access_token"] as! NSString
  let tokenExpiresAt = dictionary["expires_at"] as! NSDate

  print(token1,token2,tokenExpiresAt)
}

private func snippet_3_blocking(){
  // Assume token is stored and those message can obtain them.
  let token = getStoredToken()
  do{
    try KiiUser.authenticateWithTokenSynchronous(token)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_3_non_blocking(){
  // Assume token is stored and those message can obtain them.
  let token = getStoredToken()
  KiiUser.authenticateWithToken(token, andBlock:{(usr : KiiUser?, error : NSError?)->Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}

private func snippet_4_blocking(){
  let user : KiiUser?

  do{
    user = try KiiUser.authenticateWithStoredCredentialsSynchronous()
    try user?.refreshSynchronous()
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_4_non_blocking(){
  KiiUser.authenticateWithStoredCredentials({ (user : KiiUser?, error : NSError?) -> Void in

    if error != nil {/* Error handling */ return} // you can remove this line if you don't care about handling the error
    user?.refreshWithBlock {(user : KiiUser?, error : NSError?)->Void in
      if (error != nil) {
        // Error handling
        return
      }
    }
  })
}
private func getStoredToken() -> String {
  return ""
}
private func getStoredTokenExpiresAt() -> NSDate {
  return NSDate()
}
private func snippet_5_blocking(){
  let token = getStoredToken()
  let expiresAt = getStoredTokenExpiresAt()
  do{
    try KiiUser.authenticateWithTokenSynchronous(token, andExpiresAt: expiresAt)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_5_non_blocking(){
  let token = getStoredToken()
  let expiresAt = getStoredTokenExpiresAt()
  KiiUser.authenticateWithToken(token, andExpiresAt: expiresAt, andBlock: {(usr : KiiUser?, error : NSError?)->Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}