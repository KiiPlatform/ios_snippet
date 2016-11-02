//
//  managing-groups_creating-a-group.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-groups/creating-a-group/
//Creating a Group
private func snippet_1_blocking(){
  
  let group = KiiGroup(name: "myGroup")
  do{
    try group.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
  
  // Get the reference URI.
  let groupUri = group.objectURI
  
  // Get the reference ID.
  let groupID = group.groupID
  
  //dummy just to silence warning
  print(groupUri,groupID)
}

private func snippet_1_non_blocking(){
  
  let group = KiiGroup(name: "myGroup")
  
  group.saveWithBlock { (group : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Get the reference URI.
    let groupUri = group!.objectURI
    
    // Get the reference ID.
    let groupID = group!.groupID
    //dummy just to silence warning
    print(groupUri,groupID)
  }
}

private func snippet_1b_blocking(){

  let group = KiiGroup(name: "myGroup", andMembers: [KiiUser(ID: "member's user_id")])
  do{
    try group.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  // Get the reference URI.
  let groupUri = group.objectURI

  // Get the reference ID.
  let groupID = group.groupID

  //dummy just to silence warning
  print(groupUri,groupID)
}

private func snippet_1b_non_blocking(){

  let group = KiiGroup(name: "myGroup", andMembers: [KiiUser(ID: "member's user_id")])

  group.saveWithBlock { (group : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Get the reference URI.
    let groupUri = group!.objectURI

    // Get the reference ID.
    let groupID = group!.groupID
    //dummy just to silence warning
    print(groupUri,groupID)
  }
}


private func snippet_1a_blocking(){
  do{
    let groupID : String = "my-group-" + KiiUser.currentUser()!.userID!
    
    let group = try KiiGroup.registerGroupSynchronousWithID(groupID, name: "myGroup", members: [KiiUser(ID: "member's user_id")])
    // Get the reference URI.
    let groupUri = group.objectURI
    // group.groupID same as groupID
    //dummy just to silence warning
    print(groupUri,groupID)
  }catch (let error as NSError){
    // Group creation failed for some reasons.
    // Please check NSError to see what went wrong...
    print(error)
    return
  }
}

private func snippet_1a_non_blocking(){
  let groupID : String = "my-group-" + KiiUser.currentUser()!.userID!
  
  KiiGroup.registerGroupWithID(groupID, name: "myGroup", members: [KiiUser(ID: "member's user_id")]) { (group : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Group creation failed for some reasons.
      // Please check NSError to see what went wrong...
      return
    }
    // Get the reference URI.
    let groupUri = group!.objectURI
    // group.groupID same as groupID
    //dummy just to silence warning
    print(groupUri,groupID)
  }
}
private let group = KiiGroup(name: "myGroup")
//Retrieving a Group with URI
private func snippet_2_blocking(){
  // Get URI from the existing group.
  // You should get the URI just after the creation of the group.
  let groupUri = group.objectURI!
  
  // ... In another situation ...
  
  // Instantiate the group again.
  // (Assume that groupUri has the reference URI of the target group).
  let group2 = KiiGroup(URI: groupUri)
  
  do{
    try group2.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
  
  // Do something with the group reference.
}

private func snippet_2_non_blocking(){
  
  // Get URI from the existing group.
  // You should get the URI just after the creation of the group.
  let groupUri = group.objectURI!
  
  // ... In another situation ...
  
  // Instantiate the group again.
  // (Assume that groupUri has the reference URI of the target group).
  let group2 = KiiGroup(URI: groupUri)
  group2.refreshWithBlock{ (group2 : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Do something with the group reference.
  }
}
//Retrieving a Group with ID
//Retrieving a Group with ID
private func snippet_3_blocking(){
  // Get ID from the existing group.
  // You should get the URI just after the creation of the group.
  let groupID = group.groupID!

  // ... In another situation ...

  // Instantiate the group again.
  // (Assume that groupID has the reference ID of the target group).
  let group2 = KiiGroup(ID: groupID)

  do{
    try group2.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  // Do something with the group reference.
}

private func snippet_3_non_blocking(){
  // Get ID from the existing group.
  // You should get the ID just after the creation of the group.
  let groupID = group.groupID!

  // ... In another situation ...

  // Instantiate the group again.
  // (Assume that groupID has the reference ID of the target group).
  let group2 = KiiGroup(ID: groupID)
  group2.refreshWithBlock{ (group2 : KiiGroup?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Do something with the group reference.
  }
}

