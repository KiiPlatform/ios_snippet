//
//  guides_ios_guidelines_api.swift
//  Snippet2.3
//
//  Created by syahRiza on 10/27/16.
//  Copyright © 2016 RSyah. All rights reserved.
//

import Foundation


// Blocking vs. Non-Blocking API

private func snippet_1(){

  let user = KiiUser(username: "my_username", andPassword: "mypassword")

  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error)
    // Performing user registration failed
    // Please check error description/code to see what went wrong...
    return
  }

}

//Using Blocks
private func snippet_2(){
  let user = KiiUser(username: "my_username", andPassword: "mypassword")

  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
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
