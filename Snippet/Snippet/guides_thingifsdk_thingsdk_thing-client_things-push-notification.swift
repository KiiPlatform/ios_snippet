//
//  guides_thingifsdk_thingsdk_thing-client_things-push-notification.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/things-push-notification
//Using "Push to App" Notification
private func snippet_1_blocking(){
    let thing : KiiThing
    do{
        thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    }catch(let error as NSError){
        //Error Handling
        print(error)
        return;
    }
    let thingBucket = thing.bucketWithName("thing_bucket")
    var error: NSError?
    KiiUser.currentUser().pushSubscription().subscribeSynchronous(thingBucket, error: &error)
    if error != nil {
        // Error handling
        return;
    }
}
private func snippet_1_non_blocking(){
    KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        let thingBucket = thing.bucketWithName("thing_bucket")
        KiiUser.currentUser().pushSubscription().subscribe(thingBucket, block: { (subscription, error ) -> Void in
            if error != nil {
                // Error handling
                return;
            }
        })
    }
}
//thing subscription
private func snippet_2_blocking(){
    let thing : KiiThing
    do{
        thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    }catch(let error as NSError){
        //Error Handling
        print(error)
        return;
    }
    let thingBucket = thing.bucketWithName("thing_bucket")
    var error: NSError?
    thing.pushSubscription().subscribeSynchronous(thingBucket, error: &error)
    if error != nil {
        // Error handling
        return;
    }
}
private func snippet_2_non_blocking(){
    KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        let thingBucket = thing.bucketWithName("thing_bucket")
        thing.pushSubscription().subscribe(thingBucket, block: { (subscription, error ) -> Void in
            if error != nil {
                // Error handling
                return;
            }
        })
    }
}
//Using "Push to User" Notification
private func snippet_3_blocking(){
    let thing : KiiThing
    do{
        thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    }catch(let error as NSError){
        //Error Handling
        print(error)
        return;
    }
    let thingTopic = thing.topicWithName("thing_topic")
    var error: NSError?
    KiiUser.currentUser().pushSubscription().subscribeSynchronous(thingTopic, error: &error)
    if error != nil {
        // Error handling
        return;
    }
}
private func snippet_3_non_blocking(){
    KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        let thingTopic = thing.topicWithName("thing_topic")
        KiiUser.currentUser().pushSubscription().subscribe(thingTopic, block: { (subscription, error ) -> Void in
            if error != nil {
                // Error handling
                return;
            }
        })
    }
}
//thing subscription
private func snippet_4_blocking(){
    let thing : KiiThing
    do{
        thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
    }catch(let error as NSError){
        //Error Handling
        print(error)
        return;
    }
    let thingTopic = thing.topicWithName("thing_topic")
    var error: NSError?
    thing.pushSubscription().subscribeSynchronous(thingTopic, error: &error)
    if error != nil {
        // Error handling
        return;
    }
}
private func snippet_4_non_blocking(){
    KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        let thingTopic = thing.topicWithName("thing_topic")
        thing.pushSubscription().subscribe(thingTopic, block: { (subscription, error ) -> Void in
            if error != nil {
                // Error handling
                return;
            }
        })
    }
}
