//
//  managing-users_social-network-integration_getting-linked-social-network.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path managing-users/social-network-integration/getting-linked-social-network/

private func snippet_1(){
  let userURI = "put existing user uri here"
  let userWithURI = KiiUser(URI: userURI)
  do{
    try userWithURI.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  // getting social account information
  for (_,value) in userWithURI.linkedSocialAccounts {
    let info = value as! KiiSocialAccountInfo
    print("Provider Code : \(info.provider)")
    print("Created at : \(info.createdAt)")
    print("Social AccountId code: \(info.socialAccountId)")
    
  }
}

//Checking if a Service is already Integrated
private func snippet_2(){
  let user = KiiUser(URI: "put existing user uri here")
  do{
    try user.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  if user.isLinkedWithSocialProvider(.Facebook) {
    // User is linked to the Facebook account.
  }
  if user.isLinkedWithSocialProvider(.Twitter){
    // User is linked to the Twitter account.
  }
  
}

