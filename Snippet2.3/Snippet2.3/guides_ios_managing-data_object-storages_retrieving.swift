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
private let id = ""
private let uri = ""
private func snippet_0(){
  // Get the ID of the existing object.
  // In this example, we assume that the object is in the application bucket
  // "_app_bucket_".
  let id = object!.uuid
  print(id)
}
//Reffering with ID
private func snippet_1_blocking(){
  // Instantiate an object in the application-scope bucket "_app_bucket_".
  let bucket = Kii.bucketWithName("_app_bucket_")
  let object = bucket.createObjectWithID(id)

  do {
    // Refresh the object to retrieve the latest data from Kii Cloud.
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
}

private func snippet_1_non_blocking(){
  // Instantiate an object in the application-scope bucket "_app_bucket_".
  let bucket = Kii.bucketWithName("_app_bucket_")
  let object = bucket.createObjectWithID(id)

  // Refresh the object to retrieve the latest data from Kii Cloud.
  object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
private func snippet_1a(){
  // Get the URL of the existing object.
  let uri = object!.objectURI
  print(uri)
}

//Referring Object by URI
private func snippet_2_blocking(){
  
  // Instantiate an object.
  let object = KiiObject(URI: uri)!

  // Refresh the object to retrieve the latest data from Kii Cloud.
  do {
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_2_non_blocking(){
  // Instantiate an object.
  let object = KiiObject(URI: uri)!

  // Refresh the object to retrieve the latest data from Kii Cloud.
  object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Getting Key-value Pairs
private func snippet_3(){
  // Assume that a KiiObject instance "object" is already refreshed
  
  // Get key-value pairs
  let score = (object!.getObjectForKey("score") as! NSNumber).integerValue
  let mode = object!.getObjectForKey("mode") as! String
  let premiumUser = (object!.getObjectForKey("premiumUser") as! NSNumber).boolValue
  
  //dummy just to silence warning
  print(score,mode,premiumUser)
}

//Getting a List of Keys
private func snippet_4_blocking(){
  
  // Retrieve an object from Kii Cloud.
  let object = bucket.createObjectWithID("_ID_OF_THE_OBJECT_")

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
  let object = bucket.createObjectWithID("_ID_OF_THE_OBJECT_")
  
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
  let gp1 = object!.getGeoPointForKey("location1")!
  let gp2 = object!.getGeoPointForKey("location2")!
  
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
  let jsonObject = object!.getObjectForKey("myJsonObject") as! NSDictionary
  
  // Get a JSON array field
  let jsonArray = object!.getObjectForKey("myJsonArray") as! NSArray
  let jsonObject1 = jsonArray.objectAtIndex(0)
  let jsonObject2 = jsonArray.objectAtIndex(1)
  
  //dummy just to silence warning
  print(jsonObject,jsonArray,jsonObject1,jsonObject2)
}
