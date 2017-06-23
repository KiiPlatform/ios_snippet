//
//  guides_ios_managing-data_object-storages_querying.m
//  Snippet3
//
//  Created by syahRiza on 11/25/16.
//  Copyright © 2016 Kii. All rights reserved.
//

#import <Foundation/Foundation.h>
@import KiiSDK;


@interface Snippet : NSObject
{
  KiiBucket* bucket;

}

@end
@implementation Snippet
-(void) snippet1_blocking{
  NSError *error = nil;
  KiiClause *hasFieldclause ;//= [KiiClause hasField:@"promotionalCode" fieldType:KiiFieldTypeString];

  // Build "all with promotionalCode" query
  KiiQuery *hasFieldQuery = [KiiQuery queryWithClause:hasFieldclause];

  // Create an array to store all the results in
  NSMutableArray *allResults = [NSMutableArray array];

  // Create a placeholder for any paginated queries
  KiiQuery *nextQuery;

  // Get an array of KiiObjects by querying the bucket
  NSArray *results = [bucket executeQuerySynchronous:hasFieldQuery nextQuery:&nextQuery error:&error];
  if (error != nil) {
    // Error handling
    return;
  }

  // Add all the results from this query to the total results
  [allResults addObjectsFromArray:results];
}
@end
