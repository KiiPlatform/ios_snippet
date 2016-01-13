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
 var error : NSError?
 
 userWithURI.refreshSynchronous(&error)
 
 if error != nil{
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
 let userURI = "put existing user uri here"
 let userWithURI = KiiUser(URI: userURI)
 var error : NSError?
 
 userWithURI.refreshSynchronous(&error)
 
 if error != nil{
  // Error handling
  return
 }
 
 if userWithURI.isLinkedWithSocialProvider(.Facebook) {
  // User is linked to the Facebook account.
 }else if userWithURI.isLinkedWithSocialProvider(.Twitter){
  // User is linked to the Twitter account.
 }
 
}

