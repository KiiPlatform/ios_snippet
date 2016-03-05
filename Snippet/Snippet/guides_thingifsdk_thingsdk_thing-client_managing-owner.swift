//
//  guides_thingifsdk_thingsdk_thing-client_managing-owner.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path guides/thingifsdk/thingsdk/thing-client/managing-owner
//Checking Owners
private func snippet_1_blocking(){
  guard let thing = try? KiiThing.loadSynchronousWithThingID("rBnvSPOXBDF9r29GJeGS") else{
    // Error handling
    return
  }
  do{
    try thing.checkIsOwnerSynchronous(KiiUser.currentUser()!)
    // Current user is owner of thing.
  }catch(let error as NSError){
    if error.kiiHttpStatus() == 404 {
      // current user is not the owner
    }else{
      // Error handling
      return
    }
  }

}
private func snippet_1_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing!.checkIsOwner(KiiUser.currentUser()!, block: { (thing, owner, isOwner, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
      if isOwner {
        // Current user is owner of thing.
      }
    })
  }
}
//group owner
private func snippet_2_blocking(){
  guard let thing = try? KiiThing.loadSynchronousWithThingID("rBnvSPOXBDF9r29GJeGS") else{
    // Error handling
    return
  }

  guard let results = try? KiiUser.currentUser()!.memberOfGroupsSynchronous() else{
    // Error handling
    return
  }

  do{
    for group in results as! [KiiGroup]{
      try thing.checkIsOwnerSynchronous(group)
    }
    // this group is owner of thing.
  }catch(let error as NSError){
    if error.kiiHttpStatus() == 404 {
      // this group is not the owner
    }else{
      // Error handling
      return
    }
  }
}
private func snippet_2_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    KiiUser.currentUser()!.memberOfGroupsWithBlock({ (user, results, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
      for group in results as! [KiiGroup]{
        thing!.checkIsOwner(group, block: { (thing, owner, isOwner, error) -> Void in
          if error != nil {
            // Error handling
            return
          }
          if isOwner {
            // this group is owner of thing.
          }
        })
      }
    })

  }
}
//Registering Owners current user
private func snippet_3_blocking(){
  guard let thing = KiiThing(ID: "th.1234-5678-abcd-efgh") else {
    // Error handling
    return
  }

  do{
    try thing.registerOwnerSynchronous(KiiUser.currentUser()!)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }


}
private func snippet_3_non_blocking(){
  let thing = KiiThing(ID: "th.1234-5678-abcd-efgh")

  thing!.registerOwner(KiiUser.currentUser()!, block: { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
}
private func snippet_4_blocking(){

  let thing : KiiThing
  do{
    try KiiThing.registerOwnerSynchronous(KiiUser.currentUser()!, vendorThingID: "rBnvSPOXBDF9r29GJeGS")
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    print(thing.thingID)
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

}
private func snippet_4_non_blocking(){
  let vendorThingID = "rBnvSPOXBDF9r29GJeGS"
  KiiThing.registerOwner(KiiUser.currentUser()!, vendorThingID: vendorThingID) { (owner, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    KiiThing.loadWithVendorThingID(vendorThingID, block: { (thing, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
      print(thing!.thingID)
    })
  }

}

//Registering Owners group
private func snippet_5_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

  let group = KiiGroup(name: "owners", andMembers: [KiiUser.currentUser()!])
  do{
    try group.saveSynchronous()
    try thing.registerOwnerSynchronous(group)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_5_non_blocking(){
  let vendorThingID = "rBnvSPOXBDF9r29GJeGS"
  KiiThing.loadWithVendorThingID(vendorThingID, block: { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let group = KiiGroup(name: "owners", andMembers: [KiiUser.currentUser()!])
    group.saveWithBlock({ (group, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
      thing!.registerOwner(group!, block: { (thing, error) -> Void in
        if error != nil {
          // Error handling
          return
        }
      })
    })
  })

}
//UnRegistering Owners current user
private func snippet_6_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    try thing.unregisterOwnerSynchronous(KiiUser.currentUser()!)
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
}
private func snippet_6_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS", block: { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing!.unregisterOwner(KiiUser.currentUser()!, block: { (thing, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  })
}
//UnRegistering Owners group
private func snippet_7_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

  let group = KiiGroup(name: "owners", andMembers: [KiiUser.currentUser()!])
  do{
    try group.saveSynchronous()
    try thing.unregisterOwnerSynchronous(group)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_7_non_blocking(){
  let vendorThingID = "rBnvSPOXBDF9r29GJeGS"
  KiiThing.loadWithVendorThingID(vendorThingID, block: { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let group = KiiGroup(name: "owners", andMembers: [KiiUser.currentUser()!])
    group.saveWithBlock({ (group, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
      thing!.unregisterOwner(group!, block: { (thing, error) -> Void in
        if error != nil {
          // Error handling
          return
        }

      })
    })

  })
}


