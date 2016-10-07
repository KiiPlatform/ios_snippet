//
//  managing-users_social-network-integration_renren.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/renren/
private var accessToken : String = "dummy_accessToken"

//Using the login UI provided by the SDK
private func snippet_1(){
  func myRegistrationMethod(){
    // Set options to nil to indicate that SDK will handle the UI
    let options : Dictionary<String,AnyObject>? = nil

    //Login

    KiiSocialConnect.log(in: .Renren, options: options) { (retUser , provider : KiiConnectorProvider, reterror : Error? ) -> Void in
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

    let options : Dictionary = ["accessToken":accessToken]

    //Login

    KiiSocialConnect.log(in: .Renren, options: options) { (retUser , provider : KiiConnectorProvider, reterror : Error? ) -> Void in
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
  let dict  = KiiSocialConnect.accessTokenDictionary(.Renren)! as NSDictionary

  // The access token.
  let accessToken = (dict.object(forKey: "oauth_token") as? String)!

  // User id provided by the social network provider.
  let providerUserId = (dict.object(forKey: "provider_user_id") as? String)!

  // If a new Kii user is created with the logIn method.
  let kiiNewUser : Bool = (dict.object(forKey: "kii_new_user") as? NSNumber)!.boolValue

  //dummy to silence warning
  print(accessToken,providerUserId,kiiNewUser)
}

// Linking a Kii Account
private func snippet_4(){
  func myAccountLinkMethod(){
    // Initialize the Social Network Connector.

    // RenRen accessToken must be provided by developers
    let options : Dictionary = ["accessToken":accessToken]

    // Link to the RenRen Account.
    KiiSocialConnect.linkCurrentUser(.Renren, options: options) { (retUser , provider : KiiConnectorProvider, reterror : Error? ) -> Void in
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

    // Unlink from the RenRen Account.
    KiiSocialConnect.unLinkCurrentUser(.Renren) { (retUser , provider : KiiConnectorProvider, reterror : Error? ) -> Void in
      if (retError != nil) {
        // Error handling
        return
      }
      // The user has unlinked successfully
    }
  }
}
