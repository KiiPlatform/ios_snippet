//
//  managing-groups_listing-groups.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path /guides/ios/managing-groups/managing-groups_listing-groups

private func snippet_1_blocking(){
  // Get the currently logged in user.
  let user = KiiUser.current()
  do{
    // Get a list of groups in which the current user is a member
    let memberGroups = try user!.memberOfGroupsSynchronous() as! [KiiGroup]
    for group in memberGroups{
      // do something with each group
      //dummy just to silence warning
      print(group)
    }
  }catch(let error as NSError){
    // Error handling
    //dummy just to silence warning
    print(error)
    return
  }
}

private func snippet_1_non_blocking(){
  // Get the currently logged in user.
  let user = KiiUser.current()
  
  // Get a list of groups in which the current user is a member
  user!.memberOfGroups({ (user , results : [AnyObject]?, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let memberGroups = results as! [KiiGroup]
    for group in memberGroups{
      // do something with each group
      //dummy just to silence warning
      print(group)
    }
    
  })
}

private func snippet_2_blocking(){
  // Get the currently logged in user.
  let user = KiiUser.current()
  do{
    // Get a list of groups in which the current user is an owner
    let ownerGroups = try user!.ownerOfGroupsSynchronous() as! [KiiGroup]
    for group in ownerGroups{
      // do something with each group
      //dummy just to silence warning
      print(group)
    }
  }catch(let error as NSError){
    // Error handling
    //dummy just to silence warning
    print(error)
    return
  }
}

private func snippet_2_non_blocking(){
  // Get the currently logged in user.
  let user = KiiUser.current()
  // Get a list of groups in which the current user is an owner
  user!.ownerOfGroups({ (user , results : [AnyObject]?, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    for group in results as! [KiiGroup] {
      // do something with each group
      //dummy just to silence warning
      print(group)
    }
  })
}
