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
        thing = try KiiThing.registerThingSynchronous(
            "rBnvSPOXBDF9r29GJeGS",
            password: "123ABC",
            type: thingType,
            fields: thingFields)
        
    }catch(let error as NSError){
        //Error Handling
        print(error)
        return;
    }
    var error : NSError?
    
    thing.registerOwnerSynchronous(KiiUser.currentUser(), error: &error)
    if error != nil {
        // Error handling
        return;
    }
}
private func snippet_non_blocking(){
    let thingType = "sensor"
    let thingFields  = KiiThingFields()
    thingFields.vendor = "Kii"
    KiiThing.registerThing(
        "rBnvSPOXBDF9r29GJeGS",
        password: "123ABC",
        type: thingType,
        fields: thingFields) { (thing, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        thing.registerOwner(KiiUser.currentUser(), block: { (thing, error ) -> Void in
            if error != nil {
                // Error handling
                return;
            }
        })
    }
}
