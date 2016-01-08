//
//  ios_managing-data_object-storages_downloading_terminate.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/downloading/terminate
private let mDownloader = KiiObject(URI: "dummy").downloader("dummy")

private func snippet(){
    var error : NSError?
    // Assume that mUploader is the downloader you want to terminate.
    
    // Terminate downloading.
    mDownloader.terminate(&error)
    
    if error != nil {
        // Error handling
        return
    }
}