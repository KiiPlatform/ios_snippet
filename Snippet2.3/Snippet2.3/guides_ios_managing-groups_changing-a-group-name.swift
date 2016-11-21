//
//  managing-groups_changing-a-group-name.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path /guides/ios/managing-groups/changing-a-group-name/
private let groupUri = "groupURI"
private let group = KiiGroup(URI: groupUri)

private func snippet_blocking(){
  
  do{
    try group.changeGroupNameSynchronous("myNewGroupName")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func snippet_non_blocking(){
  group.changeGroupName("myNewGroupName") { (group : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}