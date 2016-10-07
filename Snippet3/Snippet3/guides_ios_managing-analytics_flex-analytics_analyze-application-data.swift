//
//  managing-analytics_flex-analytics_analyze-application-data.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path en/guides/ios/managing-analytics/flex-analytics/analyze-application-data/

private func snippet_blocking(){
  // Create analytics result filter
  let filter = KAFilter()
  filter.add("AppVersion", withValue: "9")

  // Set date range
  let start = Date(timeIntervalSinceNow: -1*60*60*24*7)
  let end = Date()
  let range = KADateRange(start: start, andEnd: end)

  // Create query
  let query = KAResultQuery()
  // Set grouping key to query
  query.groupingKey = "UserLevel"
  // Set filter to query
  query.filter = filter
  // Set date range to query
  query.dateRange = range;

  let aggregationID = "22"

  do{
    let result: KAGroupedResult! = try KiiAnalytics.getResultSynchronous(withID: aggregationID, andQuery: query)
    // proceed the result.
    print(result)
  }catch let error as NSError{
    // Error handling
    print(error)
    return
  }
}

private func snippet_non_blocking(){
  // Create analytics result filter
  let filter = KAFilter()
  filter.add("AppVersion", withValue: "9")

  // Set date range
  let start = Date(timeIntervalSinceNow: -1*60*60*24*7)
  let end = Date()
  let range = KADateRange(start: start, andEnd: end)

  // Create query
  let query = KAResultQuery()
  // Set grouping key to query
  query.groupingKey = "UserLevel"
  // Set filter to query
  query.filter = filter
  // Set date range to query
  query.dateRange = range;

  let aggregationID = "22"

  KiiAnalytics.getResultWithID(aggregationID, andQuery: query, andBlock:
    { (result: KAGroupedResult?, error) -> Void in
      if (error != nil) {
        // Error handling
        return
      }
    }
  )
}
