//
//  ios_managing-data_object-storages_downloading_suspend.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/downloading/suspend
private let mDownloader = KiiObject(URI: "dummy").downloader("dummy")

private func snippet(){
 // Assume that mDownloader is the downloader you want to suspend.
 
 // Suspend uploading
 var error : NSError?
 mDownloader.suspend(&error)
 
 if error != nil {
  // Error handling
  return
 }
}