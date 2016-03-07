//
//  managing-users_social-network-integration_facebook.swift
//  Snippet
//
//  Created by syahRiza on 12/11/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/facebook/
private var accessToken : String = "dummy_accessToken"
//Using the login UI provided by the SDK
private func snippet_1(){
  func myRegistrationMethod(){
    // Set options to nil to indicate that SDK will handle the UI
    let options : Dictionary<String,AnyObject>? = nil

    //Login

    KiiSocialConnect.logIn(.Facebook, options: options) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has logged in successfully
    }
  }
}

// Using the Facebook access token
private func snippet_2(){
  func myRegistrationMethod(){
    // Set target provider to login
    let options : Dictionary = ["accessToken":accessToken]

    //Login

    KiiSocialConnect.logIn(.Facebook, options: options) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
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
  let dict  = KiiSocialConnect.accessTokenDictionary(.Facebook)! as NSDictionary

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

    // Facebook accessToken must be provided by developers
    let options : Dictionary = ["accessToken":accessToken]

    // Link to the Facebook Account.
    KiiSocialConnect.linkCurrentUser(.Facebook, options: options) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
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

    // Unlink from the Facebook Account.
    KiiSocialConnect.unLinkCurrentUser(.Facebook) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has unlinked successfully
    }
  }
}