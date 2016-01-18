//
//  ios_managing-data_buckets_deleting.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/deleting/
private func snippet_blocking(){
  var error : NSError?
  let bucket = Kii.bucketWithName("__KII_BUCKET_")
  bucket.deleteSynchronous(&error)
  if (error != nil) {
    // Error handling
    return
  }
}

private func snippet_non_blocking(){
  let bucket = Kii.bucketWithName("__KII_BUCKET_")
  bucket.deleteWithBlock { (retObj, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}