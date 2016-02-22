//
//  guides_thingifsdk_thingsdk_thing-client_deleting-things.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/deleting-things

private func snippet_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  
  do{
    try thing.deleteSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing!.delete({ (deletedThing, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
