//
//  ios_managing-data_object-storages_updating.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/updating/

//Full Update without overwrite check
private func snippet_1_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create/add new values
  object.setObject(NSNumber(value: 1 as Int), forKey: "myid")
  object.setObject("John Doe Jr", forKey: "name")
  object.setObject("john_jr@example.com", forKey: "email")

  // This will remove all key/value pairs on the server,
  // replacing them with the locally-generated data
  do{
    try object.saveAllFieldsSynchronous(true)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create/add new values
  object.setObject(NSNumber(value: 1 as Int), forKey: "myid")
  object.setObject("John Doe Jr", forKey: "name")
  object.setObject("john_jr@example.com", forKey: "email")

  // This will remove all key/value pairs on the server,
  // replacing them with the locally-generated data
  object.saveAllFields(true, with: { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
}

//Partial Update without Overwrite Check
private func snippet_2_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create/add new values
  object.setObject(NSNumber(value: 1 as Int), forKey: "myid")
  object.setObject("John Doe Jr", forKey: "name")
  object.setObject("john_jr@example.com", forKey: "email")

  // This will append the local key/value pairs with the data
  // that already exists on the server

  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create/add new values
  object.setObject(NSNumber(value: 1 as Int), forKey: "myid")
  object.setObject("John Doe Jr", forKey: "name")
  object.setObject("john_jr@example.com", forKey: "email")

  // This will append the local key/value pairs with the data
  // that already exists on the server
  object.save { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Full Update with Overwrite Check
private func snippet_3_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create/add new values
  do{
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  object.setObject(NSNumber(value: 1 as Int), forKey: "myid")
  object.setObject("John Doe Jr", forKey: "name")
  object.setObject("john_jr@example.com", forKey: "email")

  // This will remove all key/value pairs on the server,
  // replacing them with the locally-generated data
  do{
    try object.saveAllFieldsSynchronous(false)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_3_non_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  // Create/add new values
  object.refresh { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    object!.setObject(NSNumber(value: 1 as Int), forKey: "myid")
    object!.setObject("John Doe Jr", forKey: "name")
    object!.setObject("john_jr@example.com", forKey: "email")

    // This will remove all key/value pairs on the server,
    // replacing them with the locally-generated data
    object!.saveAllFields(false, with: { (object : KiiObject?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}

