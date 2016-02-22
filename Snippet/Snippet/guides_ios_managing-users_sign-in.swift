//
//  guides_ios_managing-users_sign-in.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/sign-in/

private func sign_in_1_synch(){
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

private func sign_in_1_asynch(){
  let username = "user123456"
  let password = "123ABC"
  
  KiiUser.authenticate(username, withPassword: password) { (user, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func sign_in_Token(){
  // Assume user is signed-in
  
  // Method #1: Retrieve access token with the accessToken
  let token1 = KiiUser.currentUser()!.accessToken
  
  // Method #2: Retrieve access token with acceessTokenDictonary
  let dictionary = KiiUser.currentUser()!.accessTokenDictionary()!
  let token2 = dictionary["access_token"] as! NSString
  let tokenExpiresAt = dictionary["expires_at"] as! NSDate
  
  //just to avoid warnings
  print(token1,token2,tokenExpiresAt)
}

private func sign_in_2_synch(){
  // Assume token is stored and those message can obtain them.
  let token = "" //self.getStoredToken()
  do{
    try KiiUser.authenticateWithTokenSynchronous(token)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func sign_in_2_asynch(){
  // Assume token is stored and those message can obtain them.
  let token = "" //self.getStoredToken()
  KiiUser.authenticateWithToken(token, andBlock:{(usr, error)->Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}

private func sign_in_stroredcredential_synch(){
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

private func sign_in_stroredcredential_asynch(){
  KiiUser.authenticateWithStoredCredentials({ (user, error) -> Void in
    
    if error != nil {/* Error handling */ return} // you can remove this line if you don't care about handling the error
    user?.refreshWithBlock {(user, error)->Void in
      if (error != nil) {
        // Error handling
        return
      }
    }
  })
}
private func sign_in_3_synch(){
  let token = ""//self.getStoredToken()
  let expiresAt = NSDate()//self.getStoredTokenExpiresAt()
  do{
    try KiiUser.authenticateWithTokenSynchronous(token, andExpiresAt: expiresAt)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func sign_in_3_asynch(){
  let token = ""//self.getStoredToken()
  let expiresAt = NSDate()//self.getStoredTokenExpiresAt()
  KiiUser.authenticateWithToken(token, andExpiresAt: expiresAt, andBlock: {(usr, error)->Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}