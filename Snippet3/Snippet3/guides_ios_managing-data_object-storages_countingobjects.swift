//
//  ios_managing-data_object-storages_countingobjects.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/countingobjects/

//Counting All Objects in Bucket
private func snippet_1_blocking(){
  
  let bucket = Kii.bucket(withName: "people")
  do{
    let count = try bucket.countObjectsSynchronous()
    print("Number of objects :\(count)")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  let bucket = Kii.bucket(withName: "people")

  bucket.count { (retBucket : KiiBucket?, retQuery : KiiQuery?, result : UInt, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // retQuery argument has a query that matches with all objects in the bucket
    print("Number of objects :\(result)")
  }
}

//Counting Objects in Bucket with Query
private func snippet_2_blocking(){
  
  let bucket = Kii.bucket(withName: "people")
  let clause = KiiClause.greaterThanOrEqual("age", value: NSNumber(value: 25 as Int))
  let query = KiiQuery(clause: clause)
  do{
    let count = try bucket.countObjectsSynchronous(query, error: ())
    print("Number of objects :\(count)")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_2_non_blocking(){
  let bucket = Kii.bucket(withName: "people")
  let clause = KiiClause.greaterThanOrEqual("age", value: NSNumber(value: 25 as Int))
  let query = KiiQuery(clause: clause)
  
    bucket.count(with: query) { (retBucket : KiiBucket? , retQuery : KiiQuery?, result : UInt, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    print("Number of objects :\(result)")
  }
}
