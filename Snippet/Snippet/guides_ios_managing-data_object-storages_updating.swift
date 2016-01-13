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
 let object = KiiObject(URI: "put existing object uri here")
 var error : NSError?
 
 
 // Create/add new values
 object.setObject(NSNumber(integer: 1), forKey: "myid")
 object.setObject("John Doe Jr", forKey: "name")
 object.setObject("john_jr@example.com", forKey: "email")
 
 object.saveAllFieldsSynchronous(true, withError: &error)
 
 if error != nil {
  // Error handling
  return;
 }
}

private func snippet_1_non_blocking(){
 let object = KiiObject(URI: "put existing object uri here")
 
 // Create/add new values
 object.setObject(NSNumber(integer: 1), forKey: "myid")
 object.setObject("John Doe Jr", forKey: "name")
 object.setObject("john_jr@example.com", forKey: "email")
 
 object.saveAllFields(true, withBlock: { (retObject, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
 })
}

//Partial Update without Overwrite Check
private func snippet_2_blocking(){
 let object = KiiObject(URI: "put existing object uri here")
 
 // Create/add new values
 object.setObject(NSNumber(integer: 1), forKey: "myid")
 object.setObject("John Doe Jr", forKey: "name")
 object.setObject("john_jr@example.com", forKey: "email")
 
 var error : NSError?
 
 object.saveSynchronous(&error)
 
 if error != nil {
  // Error handling
  return;
 }
}

private func snippet_2_non_blocking(){
 let object = KiiObject(URI: "put existing object uri here")
 
 // Create/add new values
 object.setObject(NSNumber(integer: 1), forKey: "myid")
 object.setObject("John Doe Jr", forKey: "name")
 object.setObject("john_jr@example.com", forKey: "email")
 
 object.saveWithBlock { (retObject, error) -> Void in
  if error != nil {
   // Error handling
   return;
  }
 }
}

//Full Update with Overwrite Check
private func snippet_3_blocking(){
 let object = KiiObject(URI: "put existing object uri here")
 var error : NSError?
 
 
 // Create/add new values
 
 object.refreshSynchronous(&error)
 if error != nil {
  // Error handling
  return;
 }
 object.setObject(NSNumber(integer: 1), forKey: "myid")
 object.setObject("John Doe Jr", forKey: "name")
 object.setObject("john_jr@example.com", forKey: "email")
 
 object.saveAllFieldsSynchronous(false, withError: &error)
 
 if error != nil {
  // Error handling
  return;
 }
}

private func snippet_3_non_blocking(){
 let object = KiiObject(URI: "put existing object uri here")
 
 // Create/add new values
 object.refreshWithBlock { (object , error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
  object.setObject(NSNumber(integer: 1), forKey: "myid")
  object.setObject("John Doe Jr", forKey: "name")
  object.setObject("john_jr@example.com", forKey: "email")
  
  object.saveAllFields(false, withBlock: { (retObject, error ) -> Void in
   if error != nil {
    // Error handling
    return;
   }
  })
 }
}

