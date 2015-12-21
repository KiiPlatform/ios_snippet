//
//  ios_managing-push-notification_push-to-user_creating-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/creating-topic/

//Creating a Group-scope Topic
private func snippet_1_blocking(){
    var error : NSError?
    
    // Create a user-scope topic
    let group = KiiGroup(name: "group Name")
    
    group.saveSynchronous(&error)
    if error != nil {
        //Error handling
        return
    }
    
    let topicName = "MyTODO"
    let topic = group.topicWithName(topicName)
    
    // Save the topic to Kii Cloud
    topic.saveSynchronous(&error)
    if error != nil {
        //Error handling
        return
    }
}
private func snippet_1_non_blocking(){
    // Create a user-scope topic
    let group = KiiGroup(name: "group Name")
    group.saveWithBlock { (group, error ) -> Void in
        if error != nil {
            //Error handling
            return
        }
        let topicName = "MyTODO"
        let topic = group.topicWithName(topicName)
        
        // Save the topic to Kii Cloud
        topic.saveWithBlock { (retTopic, error ) -> Void in
            if error != nil {
                //Error handling
                return
            }
        }
    }
    
}

//Creating a User-scope Topic
private func snippet_2_blocking(){
    var error : NSError?
    
    // Create a user-scope topic
    let user = KiiUser.currentUser()
    let topicName = "MyTODO"
    let topic = user.topicWithName(topicName)
    
    // Save the topic to Kii Cloud
    topic.saveSynchronous(&error)
    if error != nil {
        //Error handling
        return
    }

}
private func snippet_2_non_blocking(){
    // Create a user-scope topic
    let user = KiiUser.currentUser()
    let topicName = "MyTODO"
    let topic = user.topicWithName(topicName)
    
    // Save the topic to Kii Cloud
    topic.saveWithBlock { (retTopic, error ) -> Void in
        if error != nil {
            //Error handling
            return
        }
    }

}