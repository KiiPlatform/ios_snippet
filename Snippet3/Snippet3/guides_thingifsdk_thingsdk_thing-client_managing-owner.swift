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
  guard let thing = try? KiiThing.loadSynchronous(withThingID: "rBnvSPOXBDF9r29GJeGS") else{
    // Error handling
    return
  }
  do{
    try thing.checkIsOwnerSynchronous(KiiUser.current()!)
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
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing!.checkIsOwner(KiiUser.current()!, block: { (thing : KiiThing, owner : KiiThingOwner, isOwner : Bool, error) -> Void in
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
  guard let thing = try? KiiThing.loadSynchronous(withThingID: "rBnvSPOXBDF9r29GJeGS") else{
    // Error handling
    return
  }

  guard let results = try? KiiUser.current()!.memberOfGroupsSynchronous() else{
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
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    KiiUser.current()!.memberOfGroups({ (user :KiiUser?, results : [Any]?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
      for group in results as! [KiiGroup]{
        thing!.checkIsOwner(group, block: { (thing : KiiThing, owner : KiiThingOwner, isOwner : Bool, error) -> Void in
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
  let thing = KiiThing(id: "th.1234-5678-abcd-efgh")

  do{
    try thing.registerOwnerSynchronous(KiiUser.current()!)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }


}
private func snippet_3_non_blocking(){
  let thing = KiiThing(id: "th.1234-5678-abcd-efgh")

  thing.register(KiiUser.current()!, block: { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
}
private func snippet_4_blocking(){

  let thing : KiiThing
  do{
    try KiiThing.registerOwnerSynchronous(KiiUser.current()!, vendorThingID: "rBnvSPOXBDF9r29GJeGS")
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
    print(thing.thingID)
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

}
private func snippet_4_non_blocking(){
  let vendorThingID = "rBnvSPOXBDF9r29GJeGS"
  KiiThing.register(KiiUser.current()!, vendorThingID: vendorThingID) { (owner : KiiThingOwner, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    KiiThing.load(withVendorThingID: vendorThingID, block: { (thing , error) -> Void in
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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

  let group = KiiGroup(name: "owners", andMembers: [KiiUser.current()!])
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
  KiiThing.load(withVendorThingID: vendorThingID, block: { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let group = KiiGroup(name: "owners", andMembers: [KiiUser.current()!])
    group.save({ (group : KiiGroup?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
      thing!.register(group!, block: { (thing , error) -> Void in
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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
    try thing.unregisterOwnerSynchronous(KiiUser.current()!)
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
}
private func snippet_6_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS", block: { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing!.unregisterOwner(KiiUser.current()!, block: { (thing , error) -> Void in
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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

  let group = KiiGroup(name: "owners", andMembers: [KiiUser.current()!])
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
  KiiThing.load(withVendorThingID: vendorThingID, block: { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let group = KiiGroup(name: "owners", andMembers: [KiiUser.current()!])
    group.save({ (group : KiiGroup?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
      thing!.unregisterOwner(group!, block: { (thing , error) -> Void in
        if error != nil {
          // Error handling
          return
        }

      })
    })

  })
}


