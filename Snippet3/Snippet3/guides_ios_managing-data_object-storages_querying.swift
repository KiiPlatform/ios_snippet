//
//  ios_managing-data_object-storages_querying.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/querying/
private let bucket = Kii.bucket(withName: "dummy")

//Querying for all Objects in a Bucket
private func snippet_1_blocking(){

  // Build "all" query
  let allQuery = KiiQuery(clause: nil)

  // Create an array to store all the results in
  var allResults = [Any]()

  // Create a placeholder for any paginated queries
  var nextQuery : KiiQuery?

  // Get an array of KiiObjects by querying the bucket
  do{
    let results = try bucket.executeQuerySynchronous(allQuery, nextQuery: &nextQuery)
    // Add all the results from this query to the total results
    allResults.append(results as AnyObject)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  // Build "all" query
  let allQuery = KiiQuery(clause: nil)

  // Create an array to store all the results in
  var allResults = [Any]()

  // Get an array of KiiObjects by querying the bucket
  bucket.execute(allQuery) { (query : KiiQuery?, bucket : KiiBucket, results : [Any]?, nextQuery : KiiQuery?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Add all the results from this query to the total results
    allResults.append(contentsOf: results!)
  }

}

//More Complex Query Example
private func snippet_2_blocking(){

  // Set up our clauses
  let clause1 = KiiClause.equals("gender", value: "Female")
  let clause2 = KiiClause.equals("age", value: NSNumber(value: 18 as Int))

  // Combine the clauses
  let totalClause = KiiClause.andClauses([clause1, clause2])

  // Build the query, sorting by 'age' and taking 10 results at a time
  let query = KiiQuery(clause: totalClause)
  query.sort(byAsc: "age")
  query.limit = 10

  // if all the results can't be returned in one pass
  // using the given criteria. This will be pre-configured
  // for you. A non-nil value means there is more data to retrieve
  var allResults = [Any]()

  // Get an array of KiiObjects by querying the bucket
  var nextQuery : KiiQuery?
  do{
    var results = try bucket.executeQuerySynchronous(query, nextQuery: &nextQuery)
    // Add all the results from this query to the total results
    allResults.append(results as AnyObject)
    var nextQuery2 : KiiQuery?
    // if there is more data to retreive
    if nextQuery != nil {
      // make the next query, storing the results
      results = try bucket.executeQuerySynchronous(nextQuery!, nextQuery: &nextQuery2)

      // add these results to the total array
      allResults.append(results as AnyObject)
    }
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }
}

private func snippet_2_non_blocking(){
  let clause1 = KiiClause.equals("gender", value: "Female")
  let clause2 = KiiClause.equals("age", value: NSNumber(value: 18 as Int))

  // Combine the clauses
  let totalClause = KiiClause.andClauses([clause1, clause2])

  // Build the query, sorting by 'age' and taking 10 results at a time
  let query = KiiQuery(clause: totalClause)
  query.sort(byAsc: "age")
  query.limit = 10

  // if all the results can't be returned in one pass
  // using the given criteria. This will be pre-configured
  // for you. A non-nil value means there is more data to retrieve
  var allResults = [Any]()

  bucket.execute(query) { (firstQuery : KiiQuery?, bucket : KiiBucket, results : [Any]?, nextQuery : KiiQuery?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Add all the results from this query to the total results
    allResults.append(contentsOf: results!)

    // if there is more data to retreive
    if nextQuery != nil {
      // make the next query, storing the results
      bucket.execute(nextQuery! , with: { (query : KiiQuery?, bucket : KiiBucket, results : [Any]?, nextQuery2 , error : Error?) -> Void in
        if error != nil {
          // Error handling
          return
        }

        // add these results to the total array
        allResults.append(contentsOf: results!)
      })
    }
  }
}
//GeoQuery Example
private func snippet_3_blocking(){

  let user = KiiUser.current()!
  let bucket = user.bucket(withName: "MyBucket")
  let object = bucket.createObject()
  let point = KiiGeoPoint(latitude: 35.661561, andLongitude: 139.769595)
  object.setGeoPoint(point, forKey: "location")
  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_3_non_blocking(){
  let user = KiiUser.current()!
  let bucket = user.bucket(withName: "MyBucket")
  let object = bucket.createObject()
  let point = KiiGeoPoint(latitude: 35.661561, andLongitude: 139.769595)
  object.setGeoPoint(point, forKey: "location")
  object.save { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Here is an example that queries for objects within a GeoBox (rectangle area).
private func snippet_4_blocking(){

  // Prepare the target Bucket to be queried.
  let user = KiiUser.current()!
  let bucket = user.bucket(withName: "MyBucket")

  // Define GeoBox with NorthEast and SouthWest points.
  let sw = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
  let ne = KiiGeoPoint(latitude: 36.069082, andLongitude: 140.07843)

  let clause = KiiClause.geoBox("location", northEast: sw, southWest: ne)
  let query = KiiQuery(clause: clause)

  // Execute GeoBox query.
  var allResults = [Any]()
  var nextQuery : KiiQuery?
  do{
    let results = try bucket.executeQuerySynchronous(query, nextQuery: &nextQuery)
    allResults.append(results as AnyObject)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  // Parsing the results will follow...
}

private func snippet_4_non_blocking(){
  // Prepare the target Bucket to be queried.
  let user = KiiUser.current()!
  let bucket = user.bucket(withName: "MyBucket")

  // Define GeoBox with NorthEast and SouthWest points.
  let sw = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
  let ne = KiiGeoPoint(latitude: 36.069082, andLongitude: 140.07843)

  let clause = KiiClause.geoBox("location", northEast: sw, southWest: ne)
  let query = KiiQuery(clause: clause)

  // Execute GeoBox query.
  var allResults = [Any]()
  bucket.execute(query) { (query : KiiQuery?, bucket : KiiBucket, results : [Any]?, nextQuery : KiiQuery?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }

    allResults.append(contentsOf: results!)
    // Parsing the results will follow...
  }

}
//We will also sort the query results in ascending order by the distance from GeoDistance1's center point.
private func snippet_5_blocking(){
  // Prepare the target Bucket to be queried.

  let user = KiiUser.current()!
  let bucket = user.bucket(withName: "MyBucket")

  // Define GeoDistance 1
  let center1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
  let clause1 = KiiClause.geoDistance("location", center: center1, radius: 3000, putDistanceInto: "distance_from_center1")

  // Define GeoDistance 2
  let center2 = KiiGeoPoint(latitude: 35.681382, andLongitude: 139.766084)
  let clause2 = KiiClause.geoDistance("location", center: center2, radius: 3000, putDistanceInto: nil)

  // Create a query instance and set the sorting order.
  let totalClause = KiiClause.andClauses([clause1, clause2])
  let query = KiiQuery(clause: totalClause)
  query.sort(byAsc: "_calculated.distance_from_center1")

  // Execute GeoDistance query.
  var allResults = [Any]()
  var nextQuery : KiiQuery?
  do{
    let results = try bucket.executeQuerySynchronous(query, nextQuery: &nextQuery)
    allResults.append(results as AnyObject)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

  // Parsing the results will follow...

  // An example of getting the distance from the center.
  let retObject = allResults[0] as! KiiObject
  let retPoint = retObject.getForKey("location")

  let calc = retObject.getForKey("_calculated") as! NSDictionary
  let distance = calc.object(forKey: "distance_from_center1") as! NSDecimalNumber
  //dummy
  print(retPoint,distance)
}

private func snippet_5_non_blocking(){
  // Prepare the target Bucket to be queried.
  let user = KiiUser.current()!
  let bucket = user.bucket(withName: "MyBucket")

  // Define GeoDistance 1
  let center1 = KiiGeoPoint(latitude: 35.658603, andLongitude: 139.745433)
  let clause1 = KiiClause.geoDistance("location", center: center1, radius: 3000, putDistanceInto: "distance_from_center1")

  // Define GeoDistance 2
  let center2 = KiiGeoPoint(latitude: 35.681382, andLongitude: 139.766084)
  let clause2 = KiiClause.geoDistance("location", center: center2, radius: 3000, putDistanceInto: nil)

  // Create a query instance and set the sorting order.
  let totalClause = KiiClause.andClauses([clause1,clause2])
  let query = KiiQuery(clause: totalClause)
  query.sort(byAsc: "_calculated.distance_from_center1")

  // Execute GeoDistance query.
  var allResults = [Any]()
  bucket.execute(query) { (query : KiiQuery?, bucket : KiiBucket, results : [Any]?, nextQuery : KiiQuery?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    allResults.append(contentsOf: results!)

    // Parsing the results will follow...

    // An example of getting the distance from the center.
    let retObject = allResults[0] as! KiiObject
    let retPoint = retObject.getForKey("location")

    let calc = retObject.getForKey("_calculated") as! NSDictionary
    let distance = calc.object(forKey: "distance_from_center1") as! NSDecimalNumber
    //dummy
    print(retPoint,distance)
  }
}
//Query with Predefined Keys Example
private func snippet_6_blocking(){

  // Define query conditions
  let userId = KiiUser.current()!.userID!
  let withinOneDay : Int64 = Int64(Date().timeIntervalSince1970 - 24 * 60 * 60) * 1000
  let clause1 = KiiClause.equals("_owner", value: userId)
  let clause2 = KiiClause.equals("_version", value: NSNumber(value: 1 as Int))
  let clause3 = KiiClause.equals("_created", value: NSNumber(value: withinOneDay as Int64))

  // Combine the clauses
  let totalClause = KiiClause.andClauses([clause1, clause2, clause3])

  // Fine-tune your query results
  let query = KiiQuery(clause: totalClause)
  query.sort(byAsc: "_created")
  query.limit = 10

  // Get an array of KiiObjects by querying the bucket
  var nextQuery : KiiQuery?
  do{
    let results = try bucket.executeQuerySynchronous(query, nextQuery: &nextQuery)
    //dummy
    print(results)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_6_non_blocking(){
  // Define query conditions
  let userId = KiiUser.current()!.userID!
  let withinOneDay : Int64 = Int64(Date().timeIntervalSince1970 - 24 * 60 * 60) * 1000
  let clause1 = KiiClause.equals("_owner", value: userId)
  let clause2 = KiiClause.equals("_version", value: NSNumber(value: 1 as Int))
  let clause3 = KiiClause.equals("_created", value: NSNumber(value: withinOneDay as Int64))

  // Combine the clauses
  let totalClause = KiiClause.andClauses([clause1, clause2, clause3])

  // Fine-tune your query results
  let query = KiiQuery(clause: totalClause)
  query.sort(byAsc: "_created")
  query.limit = 10

  // Get an array of KiiObjects by querying the bucket
  bucket.execute(query) { (query : KiiQuery?, bucket : KiiBucket, results : [Any]?, nextQuery : KiiQuery?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }

}
