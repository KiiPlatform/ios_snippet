//
//  managing-users_social-network-integration_box.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/box/

private func snippet_1(){
 func myRegistrationMethod(){
  // Set options to nil to indicate that SDK will handle the UI
  let options : Dictionary<String,AnyObject>? = nil
  
  KiiSocialConnect.logIn(.Box, options: options) { (users, provider, retError) -> Void in
   if (retError != nil) {
    // Error handling
    return;
   }
   // The user has logged in successfully
  }
 }
}

//accessTokenDictionary
private func snippet_3(){
 let dict  = KiiSocialConnect.accessTokenDictionary(.Box) as NSDictionary
 let accessToken = (dict.objectForKey("accessToken") as? String)!
 let providerUserId = (dict.objectForKey("provider_user_id") as? String)!
 let kiiNewUser : Bool = (dict.objectForKey("provider_user_id") as? NSNumber)!.boolValue
 
 //dummy to silence warning
 print(accessToken,providerUserId,kiiNewUser)
}
