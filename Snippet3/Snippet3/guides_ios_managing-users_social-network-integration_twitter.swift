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

    KiiSocialConnect.log(in: .Twitter, options: options) { (retUser , provider : KiiConnectorProvider, retError ) -> Void in
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

    KiiSocialConnect.log(in: .Twitter, options: options) { (retUser , provider : KiiConnectorProvider, retError ) -> Void in
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
  let accessToken = (dict.object(forKey: "oauth_token") as? String)!

  // The access secret.
  let accessTokenSecret = (dict.object(forKey: "oauth_token_secret") as? String)!

  // User id provided by the social network provider.
  let providerUserId = (dict.object(forKey: "provider_user_id") as? String)!

  // If a new Kii user is created with the logIn method.
  let kiiNewUser : Bool = (dict.object(forKey: "kii_new_user") as? NSNumber)!.boolValue

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
    KiiSocialConnect.linkCurrentUser(.Twitter, options: options) { (retUser , provider : KiiConnectorProvider, retError ) -> Void in
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

    KiiSocialConnect.unLinkCurrentUser(.Twitter) { (retUser , provider : KiiConnectorProvider, retError ) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has unlinked successfully
    }
  }
}
