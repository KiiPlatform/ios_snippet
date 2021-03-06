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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error  as Any)
    return
  }
  print(thing.thingType as Any)
}
private func snippet_1_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
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
    thing = try KiiThing.loadSynchronous(withThingID: "th.rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error  as Any)
    return
  }
  print(thing.thingType as Any)
}
private func snippet_2_non_blocking(){
  KiiThing.load(withThingID: "th.rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
