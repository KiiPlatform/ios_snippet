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
        thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    }catch(let error as NSError){
        //Error Handling
        print(error)
        return;
    }
    let thingBucket = thing.bucketWithName("thing_bucket")
    let object = thingBucket.createObject()
    object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
    var error : NSError?
    object.saveSynchronous(&error)
    if error != nil {
        // Error handling
        return;
    }
}

private func snippet_non_blocking(){
    KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        let thingBucket = thing.bucketWithName("thing_bucket")
        let object = thingBucket.createObject()
        object.setGeoPoint(KiiGeoPoint(latitude: 35.710036, andLongitude: 139.811046), forKey: "geo")
        object.saveWithBlock({ (object , error ) -> Void in
            if error != nil {
                // Error handling
                return;
            }
        })
    }
}