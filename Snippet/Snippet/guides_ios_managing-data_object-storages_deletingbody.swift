//
//  ios_managing-data_object-storages_deletingbody.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/deletingbody/
private let object = KiiObject(URI: "dummy")

private func snippet_blocking(){
  var error : NSError?
  object.deleteBodySynchronous(&error)
  if error != nil {
    // Error handling
    return
  }
}
private func snippet_non_blocking(){
  object.deleteBodyWithBlock { (retObject, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}