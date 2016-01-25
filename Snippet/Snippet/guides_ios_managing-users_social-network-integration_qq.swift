//
//  managing-users_social-network-integration_qq.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/qq/
private var accessToken : String = "dummy_accessToken"
private var openid : String = "dummy_accessToken"

// Using the Twitter access token
private func snippet_2(){
  func myRegistrationMethod(){
    // Set target provider to login
    let options : Dictionary = ["accessToken":accessToken,"openid":openid]
    
    //Login
    
    KiiSocialConnect.logIn(.QQ, options: options) { (retUser, provider, retError) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has logged in successfully
    }
  }
}

//accessTokenDictionary
private func snippet_3(){
  let dict  = KiiSocialConnect.accessTokenDictionary(.QQ) as NSDictionary
  
  // The access token.
  let accessToken = (dict.objectForKey("oauth_token") as? String)!
  
  // User id provided by the social network provider.
  let providerUserId = (dict.objectForKey("provider_user_id") as? String)!
  
  // If a new Kii user is created with the logIn method.
  let kiiNewUser : Bool = (dict.objectForKey("kii_new_user") as? NSNumber)!.boolValue
  
  //dummy to silence warning
  print(accessToken,providerUserId,kiiNewUser)
}

// Linking a Kii Account
private func snippet_4(){
  func myAccountLinkMethod(){
    // Initialize the Social Network Connector.
    
    // QQ accessToken must be provided by developers
    let options : Dictionary = ["accessToken":accessToken,"openid":openid]
    
    KiiSocialConnect.linkCurrentUser(.QQ, options: options) { (retUser, provider, retError) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has linked successfully.
    }
  }
}

// Unlinking a Kii Account
private func snippet_5(){
  func myAccountUnlinkMethod(){
    
    // Unlink from the QQ Account.
    KiiSocialConnect.unLinkCurrentUser(.QQ) { (retUser, provider, retError) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has unlinked successfully
    }
  }
}