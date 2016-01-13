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
  
  KiiSocialConnect.logIn(.Renren, options: options) { (users, provider, retError) -> Void in
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
  
  KiiSocialConnect.logIn(.Renren, options: options) { (users, provider, retError) -> Void in
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
 let dict  = KiiSocialConnect.accessTokenDictionary(.Renren) as NSDictionary
 let accessToken = (dict.objectForKey("accessToken") as? String)!
 let providerUserId = (dict.objectForKey("provider_user_id") as? String)!
 let kiiNewUser : Bool = (dict.objectForKey("provider_user_id") as? NSNumber)!.boolValue
 
 //dummy to silence warning
 print(accessToken,providerUserId,kiiNewUser)
}

// Linking a Kii Account
private func snippet_4(){
 func myAccountLinkMethod(){
  let options : Dictionary = ["accessToken":accessToken]
  
  KiiSocialConnect.linkCurrentUser(.Renren, options: options) { (users, provider, retError) -> Void in
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
  
  KiiSocialConnect.unLinkCurrentUser(.Renren) { (users, provider, retError) -> Void in
   if (retError != nil) {
    // Error handling
    return
   }
   // The user has unlinked successfully
  }
 }
}