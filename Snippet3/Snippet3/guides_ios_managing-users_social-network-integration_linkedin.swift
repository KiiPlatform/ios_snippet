//
//  managing-users_social-network-integration_linkedin.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/linkedin/

private func snippet_1(){
  func myRegistrationMethod(){
    // Set options to nil to indicate that SDK will handle the UI
    let options : Dictionary<String,AnyObject>? = nil

    //Login

    KiiSocialConnect.log(in: .LinkedIn, options: options) { (retUser , provider : KiiConnectorProvider, reterror : Error? ) -> Void in
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
  let dict  = KiiSocialConnect.accessTokenDictionary(.LinkedIn)! as NSDictionary

  // The access token.
  let accessToken = (dict.object(forKey: "oauth_token") as? String)!

  // User id provided by the social network provider.
  let providerUserId = (dict.object(forKey: "provider_user_id") as? String)!

  // If a new Kii user is created with the logIn method.
  let kiiNewUser : Bool = (dict.object(forKey: "kii_new_user") as? NSNumber)!.boolValue

  //dummy to silence warning
  print(accessToken,providerUserId,kiiNewUser)
}
