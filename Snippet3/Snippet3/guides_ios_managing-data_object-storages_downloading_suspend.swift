//
//  ios_managing-data_object-storages_downloading_suspend.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/downloading/suspend
private let mDownloader = KiiObject(uri: "dummy")!.downloader("dummy")

private func snippet(){
  // Assume that mDownloader is the downloader you want to suspend.
  
  // Suspend uploading
  
  do{
    try mDownloader.suspend()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
