//
//  ios_managing-data_buckets_creating.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/creating/
private let group = KiiGroup(id: "dummy")
private let bucket1 = Kii.bucket(withName: "my_user")

private func snippet_1(){
  // Create Application Scope Bucket
  let bucket1 = Kii.bucket(withName: "my_user")
  
  // Create Group Scope Bucket
  let bucket2 = Kii.bucket(withName: "score_card")
  
  // Create User Scope Bucket
  let bucket3 = KiiUser.current()!.bucket(withName: "my_private")
  
  //dummy just to silence warning
  print(bucket1,bucket2,bucket3)
}

private func snippet_2_blocking(){
  
  let obj1 = bucket1.createObject()
  do{
    try obj1.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  let obj1 = bucket1.createObject()
  obj1.save { (retObj : KiiObject?, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}



