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
 let group = KiiGroup(URI: groupUri)
 var error : NSError?
 
 group.deleteSynchronous(&error)
 
 if error != nil {
  //Error Handling
  return
 }
}

private func snippet_non_blocking(){
 // Get the currently logged in user.
 let group = KiiGroup(URI: groupUri)
 
 group.deleteWithBlock { (refGroup, error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
 }
}