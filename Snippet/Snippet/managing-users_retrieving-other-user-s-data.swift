//
//  managing-users_retrieving-other-user-s-data.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/retrieving-other-user-s-data/
//Accessing user data with username
private func snippet_1_blocking(){
    let userName = "user_123456"
    let foundUser : KiiUser
    
    do{
        foundUser = try KiiUser.findUserByUsernameSynchronous(userName)
        //dummy just to silence warning
        print(foundUser)
    }catch(let error as NSError){
        //Error Handling
        //dummy just to silence warning
        print(error)
    }
    
}

private func snippet_1_non_blocking(){
    let userName = "user_123456"
    
    KiiUser.findUserByUsername(userName) { (user, error) -> Void in
        if error != nil {
            //Error Handling
            return
        }
    }
    
}
//Accessing User Data with Email Address:
private func snippet_2_blocking(){
    let email = "user_123456@example.com"
    let foundUser : KiiUser
    
    do{
        foundUser = try KiiUser.findUserByEmailSynchronous(email)
        //dummy just to silence warning
        print(foundUser)
    }catch(let error as NSError){
        //Error Handling
        //dummy just to silence warning
        print(error)
        
        return;
        
    }
}

private func snippet_2_non_blocking(){
    let email = "user_123456@example.com"
    
    KiiUser.findUserByEmail(email) { (user, error) -> Void in
        if error != nil {
            //Error Handling
            return
        }
    }
    
}
//Accessing User Data with Phone Number:
private func snippet_3_blocking(){
    let phoneNumber = "+819012345678"
    let foundUser : KiiUser
    
    do{
        foundUser = try KiiUser.findUserByPhoneSynchronous(phoneNumber)
        //dummy just to silence warning
        print(foundUser)
    }catch(let error as NSError){
        //Error Handling
        //dummy just to silence warning
        print(error)
        return;
    }}

private func snippet_3_non_blocking(){
    let phoneNumber = "+819012345678"
    
    KiiUser.findUserByPhone(phoneNumber) { (user, error) -> Void in
        if error != nil {
            //Error Handling
            return
        }
    }
    
}
//Accessing User Data with URI:
private func snippet_4_blocking(){
    let userUri = "put existing user uri here"
    let userWithURI = KiiUser(URI: userUri)
    var error : NSError?
    
    // Refresh to get the latest user info from Kii Cloud.
    userWithURI.refreshSynchronous(&error)
    
    if error != nil {
        //Error Handling
        return
    }
    let providersDictionary = userWithURI.linkedSocialAccounts
    
    //dummy just to silence warning
    print(providersDictionary)
}

private func snippet_4_non_blocking(){
    let userUri = "put existing user uri here"
    let userWithURI = KiiUser(URI: userUri)
    
    // Refresh to get the latest user info from Kii Cloud.
    userWithURI.refreshWithBlock { (user, error) -> Void in
        if error != nil {
            //Error Handling
            return
        }
        let providersDictionary = userWithURI.linkedSocialAccounts
        
        //dummy just to silence warning
        print(providersDictionary)
    }
    
}

//Accessing User Data with user ID:
private func snippet_5_blocking(){
    let userID = "__USER_ID_"
    let userWithID = KiiUser(URI: userID)
    var error : NSError?
    
    // Refresh to get the latest user info from Kii Cloud.
    userWithID.refreshSynchronous(&error)
    
    if error != nil {
        //Error Handling
        return
    }
    
    if userWithID.isLinkedWithSocialProvider(.Facebook) {
        // User is linked to the Facebook account.
    }else if userWithID.isLinkedWithSocialProvider(.Twitter){
        // User is linked to the Twitter account.
    }
}

private func snippet_5_non_blocking(){
    let userID = "__USER_ID_"
    let userWithID = KiiUser(URI: userID)
    
    // Refresh to get the latest user info from Kii Cloud.
    userWithID.refreshWithBlock { (user, error) -> Void in
        if error != nil {
            //Error Handling
            return
        }
        if userWithID.isLinkedWithSocialProvider(.Facebook) {
            // User is linked to the Facebook account.
        }else if userWithID.isLinkedWithSocialProvider(.Twitter){
            // User is linked to the Twitter account.
        }
    }
    
}
