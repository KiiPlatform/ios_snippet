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
  let user = KiiUser.currentUser()
  do{
    let memberGroups = try user.memberOfGroupsSynchronous() as! [KiiGroup]
    
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
  let user = KiiUser.currentUser()
  
  user.memberOfGroupsWithBlock({ (user, results, error) -> Void in
    
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
  let user = KiiUser.currentUser()
  do{
    let ownerGroups = try user.ownerOfGroupsSynchronous() as! [KiiGroup]
    
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
  let user = KiiUser.currentUser()
  user.ownerOfGroupsWithBlock({ (user, results, error) -> Void in
    
    if error != nil {
      // Error handling
      return
    }
    
    let ownerGroups = results as! [KiiGroup]
    for group in ownerGroups{
      // do something with each group
      //dummy just to silence warning
      print(group)
    }
  })
}
