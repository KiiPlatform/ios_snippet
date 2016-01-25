//
//  ios_mkd.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation


// Blocking vs. Non-Blocking API

private func snippet_1(){
  var error : NSError?
  
  let user = KiiUser(username: "my_username", andPassword: "mypassword")
  
  user.performRegistrationSynchronous(&error)
  if (error != nil) {
    // Performing user registration failed
    // Please check error description/code to see what went wrong...
  }
}

//Using Blocks
private func snippet_2(){
  let user = KiiUser(username: "my_username", andPassword: "mypassword")
  
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Performing user registration failed
      // Please check error description/code to see what went wrong...
    }
  }
}

//Using callback
private func snippet_2a(){
  class myDelegate : NSObject{
    func userRegistered(user:KiiUser, error: NSError?){
      print("User registered: \(user) withError: \(error)")
      if (error != nil) {
        // Performing user registration failed
        // Please check error description/code to see what went wrong...
      }
    }
    func test_asynchronous_example(){
      let user = KiiUser(username: "my_username", andPassword: "mypassword")
      user.performRegistration(self, withCallback: Selector("userRegistered"))
    }
  }
  
}
// Error handling

private func snippet_3(){
  var error : NSError?
  
  let user = KiiUser(username: "user_123456", andPassword: "123ABC")
  user.performRegistrationSynchronous(&error)
  if (error != nil) {
    // Performing user registration failed
    return
  }
}

private func snippet_4(){
  let user = KiiUser(username: "user_123456", andPassword: "123ABC")
  user.performRegistrationWithBlock { (user, error) -> Void in
    if (error != nil) {
      // Performing user registration failed
      return
    }
  }
}

// error details

private func snippet_5(){
  var error : NSError?
  
  let user = KiiUser(username: "user_123456", andPassword: "123ABC")
  
  user.performRegistrationSynchronous(&error)
  if (error != nil) {
    // Performing user registration failed
    
    // Print error code
    print("Error code : \(error?.code) ")
    
    // Print error description
    print("Error userInfo \(error?.userInfo["description"]) ")
    // Print HTTP status
    print("Error HTTP status : \(error?.kiiHttpStatus()) ")
    // Print Server error code
    print("Error summary : \(error?.kiiErrorSummary()) ")
    // Print Server error message
    print("Error Server error message : \(error?.kiiErrorMessage()) ")
    
    return
  }
}