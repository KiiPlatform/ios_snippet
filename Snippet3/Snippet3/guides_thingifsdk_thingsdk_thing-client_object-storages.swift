//
//  guides_thingifsdk_thingsdk_thing-client_object-storages.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/object-storages

private func snippet_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingBucket = thing.bucket(withName: "thing_bucket")
  let object = thingBucket.createObject()
  object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
  do {
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingBucket = thing!.bucket(withName: "thing_bucket")
    let object = thingBucket.createObject()
    object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
    object.save({ (object : KiiObject?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
