//
//  ios_managing-push-notification_push-to-user_listing-topic.swift
//  Snippet
//
//  Created by syahRiza on 12/16/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
//MARK: path managing-push-notification/push-to-user/listing-topic/
//Getting a List of Application Scope Topics
private func snippet_1_blocking(){
  var resultObj : KiiListResult
  do{
    resultObj = try Kii.listTopicsSynchronous()
  }catch(let error as NSError){
    // do something with error
    print(error.description)
    return
  }
  for topic in (resultObj.results as! [KiiTopic]){
    // Do something with topics in the result
    print(topic.name)
  }
  
  if resultObj.hasNext {
    //this time we skip error handling
    resultObj = try! Kii.listTopicsSynchronous(resultObj.paginationKey!, error: ())
    for topic in (resultObj.results as! [KiiTopic]){
      // Do something with topics in the result
      print(topic.name)
    }
  }
}
private func snippet_1_non_blocking(){

  Kii.listTopics { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
    if error != nil {
      // do something with error
      return
    }
    for topic in (resultObj!.results as! [KiiTopic]){
      // Do something with topics in the result
      print(topic.name)
    }
    
    if resultObj!.hasNext {
      Kii.listTopics((resultObj!.paginationKey)!, block: { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
        if error != nil {
          // do something with error
          return
        }
        for topic in (resultObj!.results as! [KiiTopic]){
          // Do something with topics in the result for the next page
          print(topic.name)
        }
      })
    }
  }       
}
//Getting a List of Group Scope Topics
private func snippet_2_blocking(){
  let aGroup = KiiGroup(id: "groupID")
  var resultObj : KiiListResult
  do{
    resultObj = try aGroup.listTopicsSynchronous()
  }catch(let error as NSError){
    // do something with error
    print(error.description)
    return
  }
  for topic in (resultObj.results as! [KiiTopic]){
    // Do something with topics in the result
    print(topic.name)
  }
  
  if resultObj.hasNext {
    //this time we skip error handling
    resultObj = try! Kii.listTopicsSynchronous(resultObj.paginationKey!, error: ())
    for topic in (resultObj.results as! [KiiTopic]){
      // Do something with topics in the result for the next page
      print(topic.name)
    }
  }
}
private func snippet_2_non_blocking(){
  let aGroup = KiiGroup(id: "groupID")
  aGroup.listTopics { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
    if error != nil {
      // do something with error
      return
    }
    for topic in (resultObj!.results as! [KiiTopic]){
      // Do something with topics in the result
      print(topic.name)
    }
    
    if resultObj!.hasNext {
      aGroup.listTopics(resultObj!.paginationKey, block: { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
        if error != nil {
          // do something with error
          return
        }
        for topic in (resultObj!.results as! [KiiTopic]){
          // Do something with topics in the result for the next page
          print(topic.name)
        }
      })
    }
  }       
}
//Getting a List of User Scope Topics
private func snippet_3_blocking(){
  let aUser = KiiUser(id: "UserID")
  var resultObj : KiiListResult
  do{
    resultObj = try aUser.listTopicsSynchronous()
  }catch(let error as NSError){
    // do something with error
    print(error.description)
    return
  }
  for topic in (resultObj.results as! [KiiTopic]){
    // Do something with topics in the result
    print(topic.name)
  }
  
  if resultObj.hasNext {
    //this time we skip error handling
    resultObj = try! Kii.listTopicsSynchronous(resultObj.paginationKey!, error: ())
    for topic in (resultObj.results as! [KiiTopic]){
      // Do something with topics in the result for the next page
      print(topic.name)
    }
  }
}
private func snippet_3_non_blocking(){
  let aUser = KiiUser.current()!
  aUser.listTopics { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
    if error != nil {
      // do something with error
      return
    }
    for topic in (resultObj!.results as! [KiiTopic]){
      // Do something with topics in the result
      print(topic.name)
    }
    
    if resultObj!.hasNext {
      aUser.listTopics(resultObj!.paginationKey, block: { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
        if error != nil {
          // do something with error
          return
        }
        for topic in (resultObj!.results as! [KiiTopic]){
          // Do something with topics in the result for the next page
          print(topic.name)
        }
      })
    }
  }       
  
}
//Getting a List of Thing Scope Topics
private func snippet_4_blocking(){
  var resultObj : KiiListResult
  do{
    let aThing = try KiiThing.loadSynchronous(withThingID: "th.id123455")
    resultObj = try aThing.listTopicsSynchronous()
  }catch(let error as NSError){
    // do something with error
    print(error.description)
    return
  }
  for topic in (resultObj.results as! [KiiTopic]){
    // Do something with topics in the result
    print(topic.name)
  }
  
  if resultObj.hasNext {
    //this time we skip error handling
    resultObj = try! Kii.listTopicsSynchronous(resultObj.paginationKey!, error: ())
    for topic in (resultObj.results as! [KiiTopic]){
      // Do something with topics in the result for the next page
      print(topic.name)
    }
  }
}
private func snippet_4_non_blocking(){
  let aThing = try! KiiThing.loadSynchronous(withThingID: "th.id123455")
  
  aThing.listTopics { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
    if error != nil {
      // do something with error
      return
    }
    for topic in (resultObj!.results as! [KiiTopic]){
      // Do something with topics in the result
      print(topic.name)
    }
    
    if resultObj!.hasNext {
      aThing.listTopics(resultObj!.paginationKey, block: { (resultObj : KiiListResult?, callerObject : Any?, error : Error?) -> Void in
        if error != nil {
          // do something with error
          return
        }
        for topic in (resultObj!.results as! [KiiTopic]){
          // Do something with topics in the result for the next page
          print(topic.name)
        }
      })
    }
  }       
  
}
