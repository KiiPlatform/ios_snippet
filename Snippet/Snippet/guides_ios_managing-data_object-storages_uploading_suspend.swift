//
//  ios_managing-data_object-storages_uploading_suspend.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/uploading/suspend
private let mUploader = KiiObject(URI: "dummy").uploader("dummy")

private func snippet(){
  // Assume that mUploader is the uploader you want to suspend.
  
  // Suspend uploading.
  var error : NSError?
  mUploader.suspend(&error)
  
  if error != nil {
    // Error handling
    return
  }
}
