//
//  ios_managing-data_object-storages_deletingbody.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/deletingbody/
private let object = KiiObject(uri: "dummy")

private func snippet_blocking(){
  do {
    try object!.deleteBodySynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
}
private func snippet_non_blocking(){
  object!.deleteBody { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
