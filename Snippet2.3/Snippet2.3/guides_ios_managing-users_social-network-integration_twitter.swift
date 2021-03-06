//
//  managing-users_social-network-integration_twitter.swift
//  Snippet
//
//  Created by syahRiza on 12/11/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/twitter/
private var accessToken : String = "dummy_accessToken"
private var accessTokenSecret : String = "dummy_accessToken"

//Using the login UI provided by the SDK
private func snippet_1(){
  func myRegistrationMethod(){
    // Set options to nil to indicate that SDK will handle the UI
    let options : Dictionary<String,AnyObject>? = nil

    //Login

    KiiSocialConnect.logIn(.Twitter, options: options) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
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
    let options : Dictionary = ["accessToken":accessToken,"accessTokenSecret":accessTokenSecret]

    //Login

    KiiSocialConnect.logIn(.Twitter, options: options) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
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
  let dict  = KiiSocialConnect.accessTokenDictionary(.Twitter)! as NSDictionary

  // The access token. oauth_token_secret
  let accessToken = (dict.objectForKey("oauth_token") as? String)!

  // The access secret.
  let accessTokenSecret = (dict.objectForKey("oauth_token_secret") as? String)!

  // User id provided by the social network provider.
  let providerUserId = (dict.objectForKey("provider_user_id") as? String)!

  // If a new Kii user is created with the logIn method.
  let kiiNewUser : Bool = (dict.objectForKey("kii_new_user") as? NSNumber)!.boolValue

  //dummy to silence warning
  print(accessToken,providerUserId,kiiNewUser,accessTokenSecret)
}

// Linking a Kii Account
private func snippet_4(){
  func myAccountLinkMethod(){
    // Initialize the Social Network Connector.

    // Twitter accessToken must be provided by developers
    let options : Dictionary = ["accessToken":accessToken,"accessTokenSecret":accessTokenSecret]

    // Link to the Twitter Account.
    KiiSocialConnect.linkCurrentUser(.Twitter, options: options) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
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

    KiiSocialConnect.unLinkCurrentUser(.Twitter) { (retUser : KiiUser?, provider : KiiConnectorProvider, retError : NSError?) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has unlinked successfully
    }
  }
}