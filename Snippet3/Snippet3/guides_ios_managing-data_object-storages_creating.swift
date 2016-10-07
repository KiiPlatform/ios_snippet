//
//  ios_managing-data_object-storages_creating.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/creating/
private func snippet_1_blocking(){
  let bucket = Kii.bucket(withName: "mydata")
  
  // Create an object with key/value pairs
  let object = bucket.createObject()
  object.setObject(NSNumber(value: 987 as Int32), forKey: "score")
  object.setObject("easy", forKey: "mode")
  object.setObject(NSNumber(value: false as Bool), forKey: "premiumUser")
  
  // Save the object
  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    // Error handling
    print(error.description)
    return
  }
}

private func snippet_1_non_blocking(){
  let bucket = Kii.bucket(withName: "mydata")
  
  // Create an object with key/value pairs
  let object = bucket.createObject()
  object.setObject(NSNumber(value: 987 as Int32), forKey: "score")
  object.setObject("easy", forKey: "mode")
  object.setObject(NSNumber(value: false as Bool), forKey: "premiumUser")
  
  // Save the object
  object.save { (object : KiiObject?, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_2_blocking(){
  let objectID = "score_userX"
  
  // Create an object with key/value pairs
  let bucket = Kii.bucket(withName: "mydata")
  let object = bucket.createObject(withID: objectID)
  
  object.setObject(NSNumber(value: 987 as Int32), forKey: "score")
  object.setObject("easy", forKey: "mode")
  object.setObject(NSNumber(value: false as Bool), forKey: "premiumUser")
  
  // Save the object
  do{
    try object.saveAllFieldsSynchronous(true)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
  
}

private func snippet_2_non_blocking(){
  let objectID = "score_userX"
  
  // Create an object with key/value pairs
  let bucket = Kii.bucket(withName: "mydata")
  let object = bucket.createObject(withID: objectID)
  
  object.setObject(NSNumber(value: 987 as Int32), forKey: "score")
  object.setObject("easy", forKey: "mode")
  object.setObject(NSNumber(value: false as Bool), forKey: "premiumUser")
  
  // Save the object
  object.saveAllFields(true, with: { (object : KiiObject?, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  })
}

private func snippet_3_blocking(){
  let bucket = Kii.bucket(withName: "mydata")
  
  // Create an object and set a geopoint
  let object = bucket.createObject()

  let point1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
  let point2 = KiiGeoPoint(latitude: 35.658625, andLongitude: 139.745415)
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

private func snippet_3_non_blocking(){
  let bucket = Kii.bucket(withName: "mydata")
  
  // Create an object and set a geopoint
  let object = bucket.createObject()
  
  let point1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
  let point2 = KiiGeoPoint(latitude: 35.658625, andLongitude: 139.745415)
  object.setGeoPoint(point1, forKey:"location1")
  object.setGeoPoint(point2, forKey:"location2")
  
  object.save { (object : KiiObject?, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}

private func snippet_4_blocking(){
  let bucket = Kii.bucket(withName: "mydata")
  
  // Create an object with key/value pairs
  let object = bucket.createObject()
  
  // Set a JSON object field
  let jsonObject: Dictionary = ["score": 987, "mode": "easy"] as [String : Any]
  object.setObject(jsonObject, forKey: "myObject")
  
  // Set a JSON array field
  let arrayElement1: Dictionary = ["Name": "Alice", "age": 30] as [String : Any]
  let arrayElement2: Dictionary = ["Name": "Bob", "age": 28] as [String : Any]
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
}

private func snippet_4_non_blocking(){
  let bucket = Kii.bucket(withName: "mydata")
  
  // Create an object with key/value pairs
  let object = bucket.createObject()
  
  // Set a JSON object field
  let jsonObject: Dictionary = ["score": 987, "mode": "easy"] as [String : Any]
  object.setObject(jsonObject, forKey: "myObject")
  
  // Set a JSON array field
  let arrayElement1: Dictionary = ["Name": "Alice", "age": 30] as [String : Any]
  let arrayElement2: Dictionary = ["Name": "Bob", "age": 28] as [String : Any]
  let jsonArray = [arrayElement1, arrayElement2]
  object.setObject(jsonArray, forKey: "myArray")
  
  // Save the object
  object.save { (object : KiiObject?, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
