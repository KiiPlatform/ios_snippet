//
//  guides_thingifsdk_thingsdk_thing-client_register.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path guides/thingifsdk/thingsdk/thing-client/register/

private func snippet_blocking(){
  let thingType = "sensor"
  let thingFields  = KiiThingFields()
  thingFields.vendor = "Kii"

  let thing : KiiThing
  do{
    thing = try KiiThing.registerSynchronous(
      "rBnvSPOXBDF9r29GJeGS",
      password: "123ABC",
      type: thingType,
      fields: thingFields)
    try thing.registerOwnerSynchronous(KiiUser.current()!)
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }

}
private func snippet_non_blocking(){
  let thingType = "sensor"
  let thingFields  = KiiThingFields()
  thingFields.vendor = "Kii"
  KiiThing.register(
    "rBnvSPOXBDF9r29GJeGS",
    password: "123ABC",
    type: thingType,
    fields: thingFields) { (thing , error) -> Void in
      if error != nil {
        // Error handling
        return
      }
      thing?.register(KiiUser.current()!, block: { (thing , error) -> Void in
        if error != nil {
          // Error handling
          return
        }
      })
  }
}
