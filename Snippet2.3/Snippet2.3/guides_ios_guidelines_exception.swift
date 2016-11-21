//
//  guides_ios_guidelines_exception.swift
//  Snippet2.3
//
//  Created by syahRiza on 10/27/16.
//  Copyright © 2016 RSyah. All rights reserved.
//

import Foundation

private func snippet_3(){

  let user = KiiUser(username: "user_123456", andPassword: "123ABC")
  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error)
    // Performing user registration failed
    return
  }

}

private func snippet_4(){
  let user = KiiUser(username: "user_123456", andPassword: "123ABC")
  user.performRegistrationWithBlock { (user : KiiUser?, error : NSError?) -> Void in
    if (error != nil) {
      // Performing user registration failed
      return
    }
  }
}

// error details

private func snippet_5(){

  let user = KiiUser(username: "user_123456", andPassword: "123ABC")

  do{
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error)
    // Performing user registration failed

    // Print error code
    print("Error code : \(error.code) ")

    // Print error description
    print("Error userInfo \(error.userInfo["description"]) ")
    // Print HTTP status
    print("Error HTTP status : \(error.kiiHttpStatus()) ")
    // Print Server error code
    print("Error summary : \(error.kiiErrorSummary()) ")
    // Print Server error message
    print("Error Server error message : \(error.kiiErrorMessage()) ")
    return
  }
}
