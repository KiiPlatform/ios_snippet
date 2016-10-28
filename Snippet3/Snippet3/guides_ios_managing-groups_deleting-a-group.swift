//
//  managing-groups_deleting-a-group.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path /guides/ios/managing-groups/deleting-a-group/
private let groupUri = "groupURI"

private func snippet_blocking(){
  
  // Instantiate the group.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(uri: groupUri)
  
  // Delete the group.
  do {
    try group.deleteSynchronous()
  } catch let error as NSError {
    print(error  as Any)
    // Error handling
    return
  }

}

private func snippet_non_blocking(){
  // Instantiate the group again.
  // (Assume that groupUri has the reference URI of the target group).
  let group = KiiGroup(uri: groupUri)
  
  // Delete the group.
  group.delete { (group : KiiGroup?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
