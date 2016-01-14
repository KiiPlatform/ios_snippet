//
//  ios_managing-data_buckets_creating.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/creating/
private let group = KiiGroup(ID: "dummy")
private let bucket1 = Kii.bucketWithName("my_user")

private func snippet_1(){
  // Create Application Scope Bucket
  let bucket1 = Kii.bucketWithName("my_user")
  
  // Create Group Scope Bucket
  let bucket2 = Kii.bucketWithName("score_card")
  
  // Create User Scope Bucket
  let bucket3 = KiiUser.currentUser().bucketWithName("my_private")
  
  //dummy just to silence warning
  print(bucket1,bucket2,bucket3)
}

private func snippet_2_blocking(){
  var error : NSError?
  
  let obj1 = bucket1.createObject()
  
  obj1.saveSynchronous(&error)
  if (error != nil) {
    // Error handling
    return
  }
}

private func snippet_2_non_blocking(){
  let obj1 = bucket1.createObject()
  
  obj1.saveWithBlock { (retObj, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}



