//
//  ios_managing-data_object-storages_countingobjects.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/countingobjects/

//Counting All Objects in Bucket
private func snippet_1_blocking(){
    var error : NSError?
    
    let bucket = Kii.bucketWithName("people")
    
    let count = bucket.countSynchronous(&error)
    
    if error != nil {
        // Error handling
        return;
    }
    
    print("Number of objects :\(count)")
    
}

private func snippet_1_non_blocking(){
    let bucket = Kii.bucketWithName("people")
    
    bucket.count { (retBucket, retQuery, count, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        
        print("Number of objects :\(count)")
    }
}

//Counting Objects in Bucket with Query
private func snippet_2_blocking(){
    var error : NSError?
    
    let bucket = Kii.bucketWithName("people")
    
    let clause = KiiClause.greaterThanOrEqual("age", value: NSNumber(integer: 25))
    
    let query = KiiQuery(clause: clause)
    
    let count = bucket.countSynchronousWithQuery(query, andError: &error)
    
    if error != nil {
        // Error handling
        return;
    }
    
    print("Number of objects :\(count)")
    
}

private func snippet_2_non_blocking(){
    let bucket = Kii.bucketWithName("people")
    
    let clause = KiiClause.greaterThanOrEqual("age", value: NSNumber(integer: 25))
    
    let query = KiiQuery(clause: clause)
    
    bucket.countWithQuery(query) { (retBucket, retQuery, count, error ) -> Void in
        if error != nil {
            // Error handling
            return;
        }
        
        print("Number of objects :\(count)")
    }
}