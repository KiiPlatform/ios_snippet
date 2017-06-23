//
//  guides_thingifsdk_thingsdk_thing-client_retrieving-things.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path guides/thingifsdk/thingsdk/thing-client/retrieving-things
//load with vendorThingID
private func snippet_1_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  print(thing.thingType)
}
private func snippet_1_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing : KiiThing?, error: NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }

  }
}
//load with thingID
private func snippet_2_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithThingID("th.rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  print(thing.thingType)
}
private func snippet_2_non_blocking(){
  KiiThing.loadWithThingID("th.rBnvSPOXBDF9r29GJeGS") { (thing : KiiThing?, error: NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//load with thingID
private func snippet_3_blocking(){
  let user : KiiUser = KiiUser.currentUser()!
  do{
    let groups = try user.memberOfGroupsSynchronous() as! [KiiGroup]
    let query = KiiThingQuery(user, andGroups: groups)
    let queryResult = try KiiThing.querySynchronous(query)
    for thing in queryResult.results! {
      //
      print(thing)
    }

  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

}
private func snippet_3_non_blocking(){
  KiiUser.currentUser()?.memberOfGroupsWithBlock({ (user, groups , error) in
    let query = KiiThingQuery(user, andGroups: (groups as! [KiiGroup]))
    query.thingType = "LED"
    KiiThing.query(query, block: { (queryResult, query, error) in
      for thing in queryResult!.results! {
        //
        print(thing)
      }
    })
  })
}

