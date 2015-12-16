//
//  ios_managing-push-notification_push-to-user_subscribing-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/subscribing-topic/
//application-scope topic Subscribing to a topic
private func snippet_1_blocking(){
    // currently is not supported (swift compiler problem)
}
private func snippet_1_non_blocking(){
    let topicName = "SendingAlert"
    let topic = Kii.topicWithName(topicName)
    
    KiiUser.currentUser().pushSubscription().subscribe(topic) { (subscription, error ) -> Void in
        if error != nil {
            //Error handling
            return
        }
    }
}
//group-scope topic
private func snippet_2_blocking(){
    // currently is not supported (swift compiler problem)
}
private func snippet_2_non_blocking(){
    let topicName = "GroupTopic"
    let group = KiiGroup(URI: "groupURI")
    let topic = group.topicWithName(topicName)
    
    KiiUser.currentUser().pushSubscription().subscribe(topic) { (subscription, error ) -> Void in
        if error != nil {
            //Error handling
            return
        }
    }
}
//user-scope topic
private func snippet_3_blocking(){
    // currently is not supported (swift compiler problem)
}
private func snippet_3_non_blocking(){
    let user = KiiUser.currentUser()
    let topicName = "MyTODO"
    let topic = user.topicWithName(topicName)
    
    KiiUser.currentUser().pushSubscription().subscribe(topic) { (subscription, error ) -> Void in
        if error != nil {
            //Error handling
            return
        }
    }
}
//Unsubscribing from a topic
private func snippet_4_blocking(){
    // currently is not supported (swift compiler problem)
}
private func snippet_4_non_blocking(){
    let user = KiiUser.currentUser()
    let topic = user.topicWithName("testTopic")
    
    KiiUser.currentUser().pushSubscription().unsubscribe(topic) { (subscription, error ) -> Void in
        if error != nil {
            //Error handling
            return
        }
    }
}