//
//  ios_quickstart_adding-kii-cloud-sdk-to-your-application.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/quickstart/adding-kii-cloud-sdk-to-your-application/
private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]?) -> Bool {
  // Kii initialization
  Kii.begin(withID: "___APPID___", andKey: "___APPKEY___", andSite: KiiSite.US)
  return true
}
