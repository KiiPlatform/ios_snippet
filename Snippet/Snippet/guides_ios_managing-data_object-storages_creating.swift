//
//  ios_managing-data_object-storages_creating.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/creating/
private func object_storages_creating_blocking(){
  let objectID = "score_userX"
  
  // Create an object with key/value pairs
  let bucket = Kii.bucketWithName("mydata")
  guard let object = bucket.createObjectWithID(objectID) else{
    // objectID is invalid.
    return
  }
  
  object.setObject(NSNumber(int: 987), forKey: "score")
  object.setObject("easy", forKey: "mode")
  object.setObject(NSNumber(bool: false), forKey: "premiumUser")
  
  // Save the object
  do{
    try object.saveAllFieldsSynchronous(true)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func object_storages_creating_non_blocking(){
  let bucket = Kii.bucketWithName("mydata")
  
  // Create an object and set a geopoint
  let object = bucket.createObject()
  
  let point1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)!
  let point2 = KiiGeoPoint(latitude: 35.658625, andLongitude: 139.745415)!
  object.setGeoPoint(point1, forKey:"location1")
  object.setGeoPoint(point2, forKey:"location2")

  object.saveWithBlock { (object, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func object_storages_set_complex_blocking(){
  let bucket = Kii.bucketWithName("mydata")
  
  // Create an object with key/value pairs
  let object = bucket.createObject()
  
  // Set a JSON object field
  let jsonObject: Dictionary = ["score": 987, "mode": "easy"]
  object.setObject(jsonObject, forKey: "myObject")
  
  // Set a JSON array field
  let arrayElement1: Dictionary = ["Name": "Alice", "age": 30]
  let arrayElement2: Dictionary = ["Name": "Bob", "age": 28]
  let jsonArray = [arrayElement1, arrayElement2]
  object.setObject(jsonArray, forKey: "myArray")
  
  // Save the object
  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  print(arrayElement1,arrayElement2,jsonArray)
}

private func object_storages_set_complex_non_blocking(){
  let bucket = Kii.bucketWithName("mydata")
  
  // Create an object with key/value pairs
  let object = bucket.createObject()
  
  // Set a JSON object field
  let jsonObject: Dictionary = ["score": 987, "mode": "easy"]
  object.setObject(jsonObject, forKey: "myObject")
  
  // Set a JSON array field
  let arrayElement1: Dictionary = ["Name": "Alice", "age": 30]
  let arrayElement2: Dictionary = ["Name": "Bob", "age": 28]
  let jsonArray = [arrayElement1, arrayElement2]
  object.setObject(jsonArray, forKey: "myArray")
  
  // Save the object
  object.saveWithBlock { (object, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func object_storages_geo__synch(){
  let bucket = Kii.bucketWithName("mydata")
  
  // Create an object and set a geopoint
  let object = bucket.createObject()
  
  let point1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)!
  let point2 = KiiGeoPoint(latitude: 35.658625, andLongitude: 139.745415)!
  object.setGeoPoint(point1, forKey:"location1")
  object.setGeoPoint(point2, forKey:"location2")

  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}

private func object_storages_geo__asynch(){
  let bucket = Kii.bucketWithName("mydata")
  
  // Create an object and set a geopoint
  let object = bucket.createObject()
  
  let point1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)!
  let point2 = KiiGeoPoint(latitude: 35.658625, andLongitude: 139.745415)!
  object.setGeoPoint(point1, forKey:"location1")
  object.setGeoPoint(point2, forKey:"location2")
  
  object.saveWithBlock { (object, error) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
