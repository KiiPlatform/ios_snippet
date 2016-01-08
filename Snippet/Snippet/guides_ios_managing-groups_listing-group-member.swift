//
//  managing-groups_listing-member.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-groups/listing-group-member/
private let groupUri = "groupURI"
private let group = KiiGroup(URI: groupUri)

private func snippet_blocking(){
    // Instantiate the group.
    // (Assume that groupUri has the reference URI of the target group).
    
    var error : NSError?
    
    let members = try! group.getMemberListSynchronous() as! [KiiUser]
    
    for user in members{
        user.refreshSynchronous(&error)
        if error != nil {
            //Error Handling
            return
        }
    }
    
}

private func snippet_non_blocking(){
    
    group.getMemberListWithBlock { (refGroup, results, error ) -> Void in
        if error != nil {
            //Error Handling
            return
        }
        
        let members = results as! [KiiUser]
        for user in members{
            user.refreshWithBlock({ (retUser, error ) -> Void in
                if error != nil {
                    //Error Handling
                    return
                }
                
            })
        }
        
    }
    
}