//
//  ios_managing-data_object-storages_retreiving.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/retrieving/
private let object = KiiObject(URI: "dummy")
private let bucket = Kii.bucketWithName("dummy")
//Retrieving with URI
private func snippet_1_blocking(){
  
  // Get URI from the existing object.
  let uri = object.objectURI
  
  // ... In another situation ...
  
  // Retrieve an object from Kii Cloud.
  let object2 = KiiObject(URI: uri)
  do {
    try object2.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  // Get URI from the existing object.
  let uri = object.objectURI
  
  // ... In another situation ...
  
  // Retrieve an object from Kii Cloud.
  let object2 = KiiObject(URI: uri)
  object2.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
//Retrieving with ID
private func snippet_2_blocking(){
  
  // Get URI from the existing object.
  do {
    try object.refreshSynchronous()
    // ... In another situation ...
    // Retrieve an object from Kii Cloud.
    let id = object.uuid
    let object2 = bucket.createObjectWithID(id)!
    try object2.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  // Get URI from the existing object.
  object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let id = object!.uuid
    
    // ... In another situation ...
    
    // Retrieve an object from Kii Cloud.
    guard let object2 = bucket.createObjectWithID(id) else{
      // id is invalid
      return
    }
    
    object2.refreshWithBlock { (object2 : KiiObject?, error : NSError?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    }
  }
}

//Getting Key-value Pairs
private func snippet_3(){
  // Assume that a KiiObject instance "object" is already refreshed
  
  // Get key-value pairs
  let score = (object.getObjectForKey("score") as! NSNumber).integerValue
  let mode = object.getObjectForKey("mode") as! String
  let premiumUser = (object.getObjectForKey("premiumUser") as! NSNumber).boolValue
  
  //dummy just to silence warning
  print(score,mode,premiumUser)
}

//Getting a List of Keys
private func snippet_4_blocking(){
  
  // Retrieve an object from Kii Cloud.
  guard let object = bucket.createObjectWithID("_ID_OF_THE_OBJECT_") else{
    // objectID is invalid
    return
  }
  do{
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  // Convert key-value pair to Dictionary
  let dictionary = object.dictionaryValue()
  for (key,value) in dictionary {
    // Do something with the key
    print(key,value)
  }
}

private func snippet_4_non_blocking(){
  // Retrieve an object from Kii Cloud.
  guard let object = bucket.createObjectWithID("_ID_OF_THE_OBJECT_") else{
    // objectID is invalid
    return
  }
  
  object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    
    // Convert key-value pair to Dictionary
    let dictionary = object!.dictionaryValue()
    for (key,value) in dictionary {
      // Do something with the key
      print(key,value)
    }
  }
}

//Getting a GeoPoint
private func snippet_5(){
  // Assume that a KiiObject instance "object" is already refreshed
  
  // Get GeoPoints from kii object
  let gp1 = object.getGeoPointForKey("location1")!
  let gp2 = object.getGeoPointForKey("location2")!
  
  let latitude1 = gp1.latitude
  let longitude1 = gp1.longitude
  let latitude2 = gp2.latitude
  let longitude2 = gp2.longitude
  
  //dummy just to silence warning
  print(latitude1,longitude1,latitude2,longitude2)
}

//Getting Complex Data
private func snippet_6(){
  // Get a JSON object field
  let jsonObject = object.getObjectForKey("myJsonObject") as! NSDictionary
  
  // Get a JSON array field
  let jsonArray = object.getObjectForKey("myJsonArray") as! NSArray
  let jsonObject1 = jsonArray.objectAtIndex(0)
  let jsonObject2 = jsonArray.objectAtIndex(1)
  
  //dummy just to silence warning
  print(jsonObject,jsonArray,jsonObject1,jsonObject2)
}
