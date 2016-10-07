//
//  managing-analytics_flex-analytics_analyze-event-data.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path en/guides/ios/managing-analytics/flex-analytics/analyze-event-data
private func snippet() {
  // Define event type.
  let eventType = "MyUser"
  var extras = [String:AnyObject]()

  extras["gender"] = "M" as AnyObject?
  extras["city"] = "San Francisco" as AnyObject?
  extras["children"] = 2 as AnyObject?
  extras["age"] = 35 as AnyObject?

  let success = KiiAnalytics.trackEvent(eventType, withExtras: extras)
  if (!success) {
    // Error handling
    return
  }
}
private func snippet_blocking(){
  // Create analytics result filter
  let filter = KAFilter()
  filter.add("location", withValue: "UK")

  // Set date range
  let start = Date(timeIntervalSinceNow: -1*60*60*24*7)
  let end = Date()
  let range = KADateRange(start: start, andEnd: end)

  // Create query
  let query = KAResultQuery()
  // Set grouping key to query
  query.groupingKey = "gender"
  // Set filter to query
  query.filter = filter
  // Set date range to query
  query.dateRange = range
  // AggregationID
  let aggregationID = "22"

  // Retrieve result
  do{
    let result: KAGroupedResult! = try KiiAnalytics.getResultSynchronous(withID: aggregationID, andQuery: query)
    print(result)
  }catch let error as NSError{
    print(error)
    // Error handling
  }
}

private func snippet_non_blocking(){
  // Create analytics result filter
  let filter = KAFilter()
  filter.add("location", withValue: "UK")

  // Set date range
  let start = Date(timeIntervalSinceNow: -1*60*60*24*7)
  let end = Date()
  let range = KADateRange(start: start, andEnd: end)

  // Create query
  let query = KAResultQuery()
  // Set grouping key to query
  query.groupingKey = "gender"
  // Set filter to query
  query.filter = filter
  // Set date range to query
  query.dateRange = range
  // AggregationID
  let aggregationID = "22"

  // Retrieve result
  KiiAnalytics.getResultWithID(aggregationID, andQuery: query) {
    (result : KAGroupedResult?, error ) -> Void in
    if (error != nil) {
      // Error handling
      return
    }
  }
}
