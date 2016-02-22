//
//  managing-analytics_flex-analytics_analyze-application-data.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path en/guides/ios/managing-analytics/flex-analytics/analyze-application-data/

private func analytics_analyze_application_data_synch(){
  // Create analytics result filter
  let filter = KAFilter()
  filter.addFilter("AppVersion", withValue: "9")
  
  // Set date range
  let start = NSDate(timeIntervalSinceNow: -1*60*60*24*7)
  let end = NSDate()
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
    let result: KAGroupedResult! = try KiiAnalytics.getResultSynchronousWithID(aggregationID, andQuery: query)
    print(result)
    // proceed the result.
  }catch let error as NSError{
    print(error)
    // Error handling
    return
  }
}

private func analytics_analyze_application_data_asynch(){
  // Create analytics result filter
  let filter = KAFilter()
  filter.addFilter("AppVersion", withValue: "9")
  
  // Set date range
  let start = NSDate(timeIntervalSinceNow: -1*60*60*24*7)
  let end = NSDate()
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
    { (result: KAGroupedResult?, error: NSError?) -> Void in
      if (error != nil) {
        // Error handling
        return
      }
    }
  )
}
