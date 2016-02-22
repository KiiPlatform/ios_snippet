//
//  guides_thingifsdk_thingsdk_thing-client_things-status.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/things-status
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
  if !thing.disabled {
    do{
      try thing.disableSynchronous()
    } catch let error as NSError {
      print(error.description)
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
    if !thing!.disabled {
      thing!.disable({ (thing, error) -> Void in
        if error != nil {
          // Error handling
          return
        }
      })
    }
    
  }
}
//enable thing
private func snippet_2_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  if thing.disabled {
    do{
      try thing.enableSynchronous()
    } catch let error as NSError {
      print(error.description)
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
    if thing!.disabled {
      thing!.enable({ (thing, error) -> Void in
        if error != nil {
          // Error handling
          return
        }
      })
    }
  }
}
