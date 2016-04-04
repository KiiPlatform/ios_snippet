//
//  ios_managing-data_object-storages_deleting.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/deleting/

private func snippet_blocking(){
  let object = KiiObject(URI: "put existing object uri here")!
  do{
    try object.deleteSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
}
private func snippet_non_blocking(){
  let object = KiiObject(URI: "put existing object uri here")!
  
  object.deleteWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
  
}