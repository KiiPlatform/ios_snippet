//
//  managing-users_getting-current-user.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/getting-current-user/

private func snippet_blocking(){
    // Get the currently logged in user.
    let user = KiiUser.currentUser()
    var error : NSError?
    
    // Refresh to get the latest user info from Kii Cloud.
    user.refreshSynchronous(&error)
    
    if error != nil {
        //Error Handling
        return
    }
}

private func snippet_non_blocking(){
    // Get the currently logged in user.
    let user = KiiUser.currentUser()
    
    // Refresh to get the latest user info from Kii Cloud.
    user.refreshWithBlock { (user, error) -> Void in
        if error != nil {
            //Error Handling
            return
        }
    }
    
}