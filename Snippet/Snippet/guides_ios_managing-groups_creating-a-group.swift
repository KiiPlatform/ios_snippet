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
 
 let group = KiiGroup(name: "mygroup")
 var error : NSError?
 
 group.saveSynchronous(&error)
 
 if error != nil {
  //Error Handling
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
 
 let group = KiiGroup(name: "mygroup")
 
 group.saveWithBlock { (group, error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
  // Get the reference URI.
  let groupUri = group.objectURI
  // Get the reference ID.
  let groupID = group.groupID
  
  //dummy just to silence warning
  print(groupUri,groupID)
 }
}

private func snippet_1a_blocking(){
 do{
  let groupID : String = "group-" + KiiUser.currentUser().userID
  
  let group = try KiiGroup.registerGroupSynchronousWithID(groupID, name: "myGroup", members: [KiiUser(ID: "member user_id")])
  // Get the reference URI.
  let groupUri = group.objectURI
  //group.groupID same as groupID
  //dummy just to silence warning
  print(groupUri,groupID)
 }catch (let error as NSError){
  //Error Handling
  // Group creation failed for some reasons.
  // Please check NSError to see what went wrong...
  print(error)
  return
 }
}

private func snippet_1a_non_blocking(){
 let groupID : String = "group-" + KiiUser.currentUser().userID
 
 KiiGroup.registerGroupWithID(groupID, name: "myGroup", members: [KiiUser(ID: "member user_id")]) { (group, error) -> Void in
  if error != nil {
   //Error Handling
   // Group creation failed for some reasons.
   // Please check NSError to see what went wrong...
   return
  }
  // Get the reference URI.
  let groupUri = group.objectURI
  //group.groupID same as groupID
  //dummy just to silence warning
  print(groupUri,groupID)
 }
}
private let group = KiiGroup(name: "mygroup")
//Retrieving a Group with URI
private func snippet_2_blocking(){
 // Get URI from the existing group.
 // You should get the URI just after the creation of the group.
 let groupUri = group.objectURI
 var error : NSError?
 
 // ... In another situation ...
 let group2 = KiiGroup(URI: groupUri)
 
 group2.refreshSynchronous(&error)
 
 if error != nil {
  //Error Handling
  return
 }
 
 // Do something with the group reference.
}

private func snippet_2_non_blocking(){
 
 // Get URI from the existing group.
 // You should get the URI just after the creation of the group.
 let groupUri = group.objectURI
 
 // ... In another situation ...
 let group2 = KiiGroup(URI: groupUri)
 group2.refreshWithBlock{ (group2, error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
  // Do something with the group reference.
 }
}
//Retrieving a Group with ID
private func snippet_3_blocking(){
 // Get URI from the existing group.
 // You should get the URI just after the creation of the group.
 let groupID = group.groupID
 var error : NSError?
 
 // ... In another situation ...
 let group2 = KiiGroup(ID: groupID)
 
 group2.refreshSynchronous(&error)
 
 if error != nil {
  //Error Handling
  return
 }
 
 // Do something with the group reference.
}

private func snippet_3_non_blocking(){
 // Get URI from the existing group.
 // You should get the URI just after the creation of the group.
 let groupID = group.groupID
 
 // ... In another situation ...
 let group2 = KiiGroup(ID: groupID)
 group2.refreshWithBlock{ (group2, error) -> Void in
  if error != nil {
   //Error Handling
   return
  }
  // Do something with the group reference.
 }
}
