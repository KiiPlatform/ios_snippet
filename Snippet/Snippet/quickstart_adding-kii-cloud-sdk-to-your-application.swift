//
//  ios_quickstart_adding-kii-cloud-sdk-to-your-application.swift
//  Snippet
//
//  Created by syahRiza on 12/9/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/quickstart/adding-kii-cloud-sdk-to-your-application/
private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    Kii.beginWithID("___APPID___", andKey: "___APPKEY___", andSite: KiiSite.US)
    
    // Override point for customization after application launch.
    return true
}