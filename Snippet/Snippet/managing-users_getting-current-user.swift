//
//  managing-users_getting-current-user.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/getting-current-user/

private func snippet(){
    let user = KiiUser.currentUser()
    var error : NSError?
    
    user.refreshSynchronous(&error)
    
    if error != nil {
        //Error Handling
        return
    }
}