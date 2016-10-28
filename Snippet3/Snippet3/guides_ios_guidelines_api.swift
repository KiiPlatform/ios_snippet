//
//  guides_ios_guidelines_api.swift
//  Snippet3
//
//  Created by syahRiza on 10/27/16.
//  Copyright © 2016 Kii. All rights reserved.
//

import Foundation


// Blocking vs. Non-Blocking API

private func snippet_1(){

  let user = KiiUser(username: "my_username", andPassword: "mypassword")

  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error  as Any)
    // Performing user registration failed
    // Please check error description/code to see what went wrong...
    return
  }

}

//Using Blocks
private func snippet_2(){
  let user = KiiUser(username: "my_username", andPassword: "mypassword")

  user.performRegistration { (user :KiiUser?, error : Error?) -> Void in
    if (error != nil) {
      // Performing user registration failed
      // Please check error description/code to see what went wrong...
    }
  }
}

//Using callback
private func snippet_2a(){
  class myDelegate : NSObject{
    func userRegistered(user:KiiUser?, error: Error?){
      print("User registered: \(user) withError: \(error)")
      if (error != nil) {
        // Performing user registration failed
        // Please check error description/code to see what went wrong...
      }
    }
    func test_asynchronous_example(){
      let user = KiiUser(username: "my_username", andPassword: "mypassword")
      user.performRegistration(self, withCallback: Selector(("userRegistered")))
    }
  }

}
// Error handling
