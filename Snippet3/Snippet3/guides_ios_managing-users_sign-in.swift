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

  KiiUser.authenticate(username, withPassword: password) { (user :KiiUser?, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_2(){
  // Assume user is signed-in

  // Method #1: Retrieve access token with the accessToken
  let token1 = KiiUser.current()!.accessToken

  // Method #2: Retrieve access token with acceessTokenDictonary
  let dictionary = KiiUser.current()!.accessTokenDictionary()!
  let token2 = dictionary["access_token"] as! NSString
  let tokenExpiresAt = dictionary["expires_at"] as! Date

  print(token1,token2,tokenExpiresAt)
}

private func snippet_3_blocking(){
  // Assume token is stored and those message can obtain them.
  let token = getStoredToken()
  do{
    try KiiUser.authenticate(withTokenSynchronous: token)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_3_non_blocking(){
  // Assume token is stored and those message can obtain them.
  let token = getStoredToken()
  KiiUser.authenticate(withToken: token, andBlock:{(usr , error )->Void in
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
  KiiUser.authenticate(storedCredentials: { (user :KiiUser?, error : Error?) -> Void in

    if error != nil {/* Error handling */ return} // you can remove this line if you don't care about handling the error
    user?.refresh {(user :KiiUser?, error )->Void in
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
private func getStoredTokenExpiresAt() -> Date {
  return Date()
}
private func snippet_5_blocking(){
  let token = getStoredToken()
  let expiresAt = getStoredTokenExpiresAt()
  do{
    try KiiUser.authenticate(withTokenSynchronous: token, andExpiresAt: expiresAt)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_5_non_blocking(){
  let token = getStoredToken()
  let expiresAt = getStoredTokenExpiresAt()
  KiiUser.authenticate(withToken: token, andExpiresAt: expiresAt, andBlock: {(usr , error )->Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}
