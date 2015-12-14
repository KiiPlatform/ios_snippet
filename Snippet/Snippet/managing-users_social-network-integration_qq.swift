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

// Using the Twitter access token
private func snippet_2(){
    func myRegistrationMethod(){
        
        let options : Dictionary = ["accessToken":accessToken]
        
        KiiSocialConnect.logIn(.QQ, options: options) { (users, provider, retError) -> Void in
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
    let dict  = KiiSocialConnect.accessTokenDictionary(.QQ) as NSDictionary
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
        
        KiiSocialConnect.linkCurrentUser(.QQ, options: options) { (users, provider, retError) -> Void in
            if (retError != nil) {
                // Error handling
                return;
            }
            // The user has linked successfully.
        }
    }
}

// Unlinking a Kii Account
private func snippet_5(){
    func myAccountUnlinkMethod(){
        
        KiiSocialConnect.unLinkCurrentUser(.QQ) { (users, provider, retError) -> Void in
            if (retError != nil) {
                // Error handling
                return;
            }
            // The user has unlinked successfully
        }
    }
}