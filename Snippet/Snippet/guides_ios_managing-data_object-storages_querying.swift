//
//  ios_managing-data_object-storages_querying.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/querying/
private let bucket = Kii.bucketWithName("dummy")

//Querying for all Objects in a Bucket
private func snippet_1_blocking(){
 var error : NSError?
 
 let allQuery = KiiQuery(clause: nil)
 
 // Create an array to store all the results in
 var allResults = [AnyObject]()
 
 // Create a placeholder for any paginated queries
 var nextQuery : KiiQuery?
 
 // Get an array of KiiObjects by querying the bucket
 let results = bucket.executeQuerySynchronous(allQuery, withError: &error, andNext: &nextQuery)
 
 if error != nil {
  // Error handling
  return;
 }
 
 // Add all the results from this query to the total results
 allResults.appendContentsOf(results)
}

private func snippet_1_non_blocking(){
 let allQuery = KiiQuery(clause: nil)
 
 // Create an array to store all the results in
 var allResults = [AnyObject]()
 
 // Get an array of KiiObjects by querying the bucket
 bucket.executeQuery(allQuery) { (retQuery, bucket, results, nextQuery, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
  // Add all the results from this query to the total results
  allResults.appendContentsOf(results)
 }
 
}

//More Complex Query Example
private func snippet_2_blocking(){
 var error : NSError?
 
 let clause1 = KiiClause.equals("gender", value: "Female")
 let clause2 = KiiClause.equals("age", value: NSNumber(integer: 18))
 
 // Combine the clauses
 let totalClause = KiiClause.andClauses([clause1,clause2])
 
 // Fine-tune your query results
 let query = KiiQuery(clause: totalClause)
 query.sortByAsc("age")
 query.limit = 10
 
 // Create a placeholder for any paginated queries -
 // if all the results can't be returned in one pass
 // using the given criteria. This will be pre-configured
 // for you. A non-nil value means there is more data to retrieve
 var allResults = [AnyObject]()
 
 // Get an array of KiiObjects by querying the bucket
 var nextQuery : KiiQuery?
 var results = bucket.executeQuerySynchronous(query, withError: &error, andNext: &nextQuery)
 
 if error != nil {
  // Error handling
  return;
 }
 
 allResults.appendContentsOf(results)
 
 // if there is more data to retreive
 
 if nextQuery != nil {
  var nextQuery2 : KiiQuery?
  
  // make the next query, storing the results
  results = bucket.executeQuerySynchronous(nextQuery, withError: &error, andNext: &nextQuery2)
  
  if error != nil {
   // Error handling
   return;
  }
  // add these results to the total array
  allResults.appendContentsOf(results)
 }
}

private func snippet_2_non_blocking(){
 let clause1 = KiiClause.equals("gender", value: "Female")
 let clause2 = KiiClause.equals("age", value: NSNumber(integer: 18))
 
 // Combine the clauses
 let totalClause = KiiClause.andClauses([clause1,clause2])
 
 // Fine-tune your query results
 let query = KiiQuery(clause: totalClause)
 query.sortByAsc("age")
 query.limit = 10
 
 // Create a placeholder for any paginated queries -
 // if all the results can't be returned in one pass
 // using the given criteria. This will be pre-configured
 // for you. A non-nil value means there is more data to retrieve
 var allResults = [AnyObject]()
 
 bucket.executeQuery(query) { (firstQuery, retBucket, results, nextQuery, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
  // add these results to the total array
  allResults.appendContentsOf(results)
  if nextQuery != nil {
   
   // make the next query, storing the results
   bucket.executeQuery(nextQuery , withBlock: { (retQuery, retBucket, results, nextQuery2, error ) -> Void in
    if error != nil {
     // Error handling
     return;
    }
    // add these results to the total array
    allResults.appendContentsOf(results)
   })
  }
 }
}
//GeoQuery Example
private func snippet_3_blocking(){
 var error : NSError?
 
 let user = KiiUser.currentUser()
 
 let bucket = user.bucketWithName("MyBucket")
 
 let object = bucket.createObject()
 
 // Define GeoDistance 1
 let point = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
 
 object.setGeoPoint(point, forKey: "location")
 
 object.saveSynchronous(&error)
 
 if error != nil {
  // Error handling
  return;
 }
}

private func snippet_3_non_blocking(){
 let user = KiiUser.currentUser()
 
 let bucket = user.bucketWithName("MyBucket")
 
 let object = bucket.createObject()
 
 // Define GeoDistance 1
 let point = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
 
 object.setGeoPoint(point, forKey: "location")
 
 object.saveWithBlock { (retObject, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
 }
}

//Here is an example that queries for objects within a GeoBox (rectangle area).
private func snippet_4_blocking(){
 var error : NSError?
 
 let user = KiiUser.currentUser()
 
 let bucket = user.bucketWithName("MyBucket")
 
 // Define GeoDistance 1
 let sw = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
 let ne = KiiGeoPoint(latitude: 36.069082, andLongitude: 140.07843)
 
 let clause = KiiClause.geoBox("location", northEast: sw, southWest: ne)
 let query = KiiQuery(clause: clause)
 
 // Execute GeoDistance query.
 var allResults = [AnyObject]()
 
 // Get an array of KiiObjects by querying the bucket
 var nextQuery : KiiQuery?
 let results = bucket.executeQuerySynchronous(query, withError: &error, andNext: &nextQuery)
 
 if error != nil {
  // Error handling
  return;
 }
 
 allResults.appendContentsOf(results)
 // Parsing the results will follow...
}

private func snippet_4_non_blocking(){
 let user = KiiUser.currentUser()
 
 let bucket = user.bucketWithName("MyBucket")
 
 // Define GeoDistance 1
 let sw = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
 let ne = KiiGeoPoint(latitude: 36.069082, andLongitude: 140.07843)
 
 let clause = KiiClause.geoBox("location", northEast: sw, southWest: ne)
 let query = KiiQuery(clause: clause)
 
 // Get an array of KiiObjects by querying the bucket
 bucket.executeQuery(query) { (retQuery, retBucket, results, nextQuery, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
  var allResults = [AnyObject]()
  allResults.appendContentsOf(results)
  // Parsing the results will follow...
 }
 
 
}
//We will also sort the query results in ascending order by the distance from GeoDistance1's center point.
private func snippet_5_blocking(){
 var error : NSError?
 
 let user = KiiUser.currentUser()
 
 let bucket = user.bucketWithName("MyBucket")
 
 // Define GeoDistance 1
 let center1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
 let clause1 = KiiClause.geoDistance("location", center: center1, radius: 3000, putDistanceInto: "distance_from_center1")
 
 // Define GeoDistance 2
 let center2 = KiiGeoPoint(latitude: 35.681382, andLongitude: 139.766084)
 let clause2 = KiiClause.geoDistance("location", center: center2, radius: 3000, putDistanceInto: nil)
 
 // Create a query instance and set the sorting order.
 let totalClause = KiiClause.andClauses([clause1,clause2])
 
 let query = KiiQuery(clause: totalClause)
 query.sortByAsc("_calculated.distance_from_center1")
 
 // Execute GeoDistance query.
 var allResults = [AnyObject]()
 
 // Get an array of KiiObjects by querying the bucket
 var nextQuery : KiiQuery?
 let results = bucket.executeQuerySynchronous(query, withError: &error, andNext: &nextQuery)
 
 if error != nil {
  // Error handling
  return;
 }
 
 allResults.appendContentsOf(results)
 // Parsing the results will follow...
 
 // An example of getting the distance from the center.
 let retObject = allResults[0] as! KiiObject
 let retPoint = retObject.getObjectForKey("location")
 
 let calc = retObject.getObjectForKey("_calculated") as! NSDictionary
 
 let distance = calc.objectForKey("distance_from_center1") as! NSDecimalNumber
 
 //dummy
 print(retPoint,distance)
}

private func snippet_5_non_blocking(){
 let user = KiiUser.currentUser()
 
 let bucket = user.bucketWithName("MyBucket")
 
 // Define GeoDistance 1
 let center1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
 let clause1 = KiiClause.geoDistance("location", center: center1, radius: 3000, putDistanceInto: "distance_from_center1")
 
 // Define GeoDistance 2
 let center2 = KiiGeoPoint(latitude: 35.681382, andLongitude: 139.766084)
 let clause2 = KiiClause.geoDistance("location", center: center2, radius: 3000, putDistanceInto: nil)
 
 // Create a query instance and set the sorting order.
 let totalClause = KiiClause.andClauses([clause1,clause2])
 
 let query = KiiQuery(clause: totalClause)
 query.sortByAsc("_calculated.distance_from_center1")
 
 // Get an array of KiiObjects by querying the bucket
 bucket.executeQuery(query) { (retQuery, retBucket, results, nextQuery, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
  var allResults = [AnyObject]()
  allResults.appendContentsOf(results)
  // Parsing the results will follow...
  
  // An example of getting the distance from the center.
  let retObject = allResults[0] as! KiiObject
  let retPoint = retObject.getObjectForKey("location")
  
  let calc = retObject.getObjectForKey("_calculated") as! NSDictionary
  
  let distance = calc.objectForKey("distance_from_center1") as! NSDecimalNumber
  
  //dummy
  print(retPoint,distance)
 }
}
//Query with Predefined Keys Example
private func snippet_6_blocking(){
 var error : NSError?
 
 let userId = KiiUser.currentUser().userID
 
 let withinOneDay : Int64 = Int64(NSDate().timeIntervalSince1970 - 24 * 60 * 60) * 1000
 
 let clause1 = KiiClause.equals("_owner", value: userId)
 let clause2 = KiiClause.equals("_version", value: NSNumber(integer: 1))
 let clause3 = KiiClause.equals("_created", value: NSNumber(longLong: withinOneDay))
 
 // Combine the clauses
 let totalClause = KiiClause.andClauses([clause1,clause2,clause3])
 
 // Fine-tune your query results
 let query = KiiQuery(clause: totalClause)
 query.sortByAsc("_created")
 query.limit = 10
 
 // Get an array of KiiObjects by querying the bucket
 var nextQuery : KiiQuery?
 let results = bucket.executeQuerySynchronous(query, withError: &error, andNext: &nextQuery)
 
 if error != nil {
  // Error handling
  return;
 }
 
 //dummy
 print(results)
}

private func snippet_6_non_blocking(){
 let userId = KiiUser.currentUser().userID
 
 let withinOneDay : Int64 = Int64(NSDate().timeIntervalSince1970 - 24 * 60 * 60) * 1000
 
 let clause1 = KiiClause.equals("_owner", value: userId)
 let clause2 = KiiClause.equals("_version", value: NSNumber(integer: 1))
 let clause3 = KiiClause.equals("_created", value: NSNumber(longLong: withinOneDay))
 
 // Combine the clauses
 let totalClause = KiiClause.andClauses([clause1,clause2,clause3])
 
 // Fine-tune your query results
 let query = KiiQuery(clause: totalClause)
 query.sortByAsc("_created")
 query.limit = 10
 
 // Get an array of KiiObjects by querying the bucket
 bucket.executeQuery(query) { (retQuery, retBucket, results, nextQuery, error ) -> Void in
  if error != nil {
   // Error handling
   return;
  }
 }
 
}