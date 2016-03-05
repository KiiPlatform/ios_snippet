//
//  managing-users_social-network-integration_ google.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/google/
private var accessToken : String = "dummy_accessToken"

//Using the login UI provided by the SDK
private func snippet_1(){
  func myRegistrationMethod(){
    // Set options to nil to indicate that SDK will handle the UI
    let options : Dictionary<String,AnyObject>? = nil

    //Login

    KiiSocialConnect.logIn(.Googleplus, options: options) { (retUser, provider, retError) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has logged in successfully
    }
  }
}

// Using the Twitter access token
private func snippet_2(){
  func myRegistrationMethod(){
    // Set target provider to login
    let options : Dictionary = ["accessToken":accessToken]

    //Login

    KiiSocialConnect.logIn(.Googleplus, options: options) { (retUser, provider, retError) -> Void in
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
  let dict  = KiiSocialConnect.accessTokenDictionary(.Googleplus)! as NSDictionary

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

    // GooglePlus accessToken must be provided by developers
    let options : Dictionary = ["accessToken":accessToken]

    // Link to the GooglePlus Account.
    KiiSocialConnect.linkCurrentUser(.Googleplus, options: options) { (retUser, provider, retError) -> Void in
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

    // Unlink from the GooglePlus Account.
    KiiSocialConnect.unLinkCurrentUser(.Googleplus) { (retUser, provider, retError) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has unlinked successfully
    }
  }
}