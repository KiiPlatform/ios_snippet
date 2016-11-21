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
  
  let bucket = Kii.bucket(withName: "__KII_BUCKET_")
  do{
    try bucket.deleteSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_non_blocking(){
  let bucket = Kii.bucket(withName: "__KII_BUCKET_")
  bucket.delete { (retBucket : KiiBucket, error : Error?) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
