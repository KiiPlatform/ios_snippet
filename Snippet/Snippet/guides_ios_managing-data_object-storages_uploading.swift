//
//  ios_managing-data_object-storages_uploading.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/uploading/

//Uploading with Background Transfer
private func snippet_1_blocking(){
  class delegate :NSObject, NSURLSessionDataDelegate{
    //snippet start here
    func uploadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.currentUser() == nil{
        return
      }
      
      // Create an object in a user-scope bucket.
      let bucket = KiiUser.currentUser().bucketWithName("bucket001")
      let object = bucket.createObject()
      
      // Set key-value pairs.
      object.setObject("myVideo", forKey: "title")
      object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")
      
      // Save KiiObject
      var error : NSError?
      
      object.saveSynchronous(&error)
      
      if error != nil {
        print("Object creation error!")
        return
      }
      
      let contentType = "video/mp4"
      
      let uploadRequest = object.generateUploadRequest(contentType)
      
      let uuidStr = NSUUID().UUIDString
      
      let randomSessionIdentifier = uuidStr.lowercaseString
      
      let sessionConfig : NSURLSessionConfiguration
      
      if #available(iOS 8, *) {
        sessionConfig = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(randomSessionIdentifier)
      }else{
        sessionConfig = NSURLSessionConfiguration.backgroundSessionConfiguration(randomSessionIdentifier)
      }
      
      sessionConfig.allowsCellularAccess = true
      
      let session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
      
      // Prepare file to upload
      let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
      
      let sourceFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
      
      let sourceFileURL = NSURL(fileURLWithPath: sourceFilePath)
      
      // Create upload task
      let uploadTask = session.uploadTaskWithRequest(uploadRequest, fromFile: sourceFileURL)
      // Start/resume the task
      uploadTask.resume()
    }
    
    @objc private func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
      print("Progress : \(Float(totalBytesSent / totalBytesExpectedToSend))")
    }
    
    
    @objc private func URLSession(session : NSURLSession, task: NSURLSessionTask, didCompleteWithError error : NSError?){
      if error != nil {
        print("Background transfer is failed")
        return
      }
      
      let response = task.response as! NSHTTPURLResponse
      
      if response.statusCode >= 300 {
        print("Background transfer is failed, status code: \(response.statusCode)")
        return
      }
      
      print("Background transfer is success")
    }
    //snippet end here
  }
}
private func snippet_1_non_blocking(){
  class delegate :NSObject, NSURLSessionDataDelegate{
    //snippet start here
    
    func uploadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.currentUser() == nil{
        return
      }
      
      // Create an object in a user-scope bucket.
      let bucket = KiiUser.currentUser().bucketWithName("bucket001")
      let object = bucket.createObject()
      
      // Set key-value pairs.
      object.setObject("myVideo", forKey: "title")
      object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")
      
      // Save KiiObject
      
      object.saveWithBlock { (object , error ) -> Void in
        if error != nil {
          print("Object creation error!")
          return
        }
        
        let contentType = "video/mp4"
        
        let uploadRequest = object.generateUploadRequest(contentType)
        
        let uuidStr = NSUUID().UUIDString
        
        let randomSessionIdentifier = uuidStr.lowercaseString
        
        let sessionConfig : NSURLSessionConfiguration
        
        if #available(iOS 8, *) {
          sessionConfig = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(randomSessionIdentifier)
        }else{
          sessionConfig = NSURLSessionConfiguration.backgroundSessionConfiguration(randomSessionIdentifier)
        }
        
        sessionConfig.allowsCellularAccess = true
        
        let session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        // Prepare file to upload
        let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
        
        let sourceFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
        
        let sourceFileURL = NSURL(fileURLWithPath: sourceFilePath)
        
        // Create upload task
        let uploadTask = session.uploadTaskWithRequest(uploadRequest, fromFile: sourceFileURL)
        // Start/resume the task
        uploadTask.resume()
      }
      
    }
    
    @objc private func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
      print("Progress : \(Float(totalBytesSent / totalBytesExpectedToSend))")
    }
    
    
    @objc private func URLSession(session : NSURLSession, task: NSURLSessionTask, didCompleteWithError error : NSError?){
      if error != nil {
        print("Background transfer is failed")
        return
      }
      
      let response = task.response as! NSHTTPURLResponse
      
      if response.statusCode >= 300 {
        print("Background transfer is failed, status code: \(response.statusCode)")
        return
      }
      
      print("Background transfer is success")
    }
    //snippet end here
  }
  
}
//Uploading with resumable transfer
private func snippet_2_blocking(){
  // Check KiiUser is logged in
  if KiiUser.currentUser() == nil{
    return
  }
  
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
  let object = bucket.createObject()
  
  // Set key-value pairs.
  object.setObject("myVideo", forKey: "title")
  object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")
  
  // Save KiiObject
  var error : NSError?
  
  object.saveSynchronous(&error)
  
  if error != nil {
    print("Object creation error!")
    return
  }
  
  // Prepare file to upload
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  
  let sourceFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
  
  let uploader = object.uploader(sourceFilePath)
  let progress : KiiRTransferBlock = { (transferObject, error ) in
    let info = transferObject.info()
    print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
  }
  
  uploader.transferWithProgressBlock(progress, andError: &error)
  
  if error != nil {
    // Error handling
    return
  }
}
private func snippet_2_non_blocking(){
  // Check KiiUser is logged in
  if KiiUser.currentUser() == nil{
    return
  }
  
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
  let object = bucket.createObject()
  
  // Set key-value pairs.
  object.setObject("myVideo", forKey: "title")
  object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")
  
  object.saveWithBlock { (object , error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Prepare file to upload
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    
    let sourceFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
    
    let uploader = object.uploader(sourceFilePath)
    let progress : KiiRTransferBlock = { (transferObject, error ) in
      let info = transferObject.info()
      print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
    }
    let completion : KiiRTransferBlock = { (transferObject, error ) in
      if error != nil {
        // Error handling
        return
      }
    }
    uploader.transferWithProgressBlock(progress, andCompletionBlock: completion)
    
  }
  
}
//Uploading without resumable transfer
private func snippet_3_blocking(){
  // Check KiiUser is logged in
  if KiiUser.currentUser() == nil{
    return
  }
  
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
  let object = bucket.createObject()
  
  // Set key-value pairs.
  object.setObject("MyImage", forKey: "title")
  object.setObject(NSNumber(integer: 783204), forKey: "fileSize")
  
  // Save KiiObject
  var error : NSError?
  
  object.saveSynchronous(&error)
  
  if error != nil {
    print("Object creation error!")
    return
  }
  
  // Prepare file to upload
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  
  let sourceFilePath = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
  let sourceFileURL = NSURL(fileURLWithPath: sourceFilePath)
  object.uploadBodySynchronousWithURL(sourceFileURL, andContentType: "image/jpeg", andError: &error)
  
  if error != nil {
    // Error handling
    return
  }
  
}
private func snippet_3_non_blocking(){
  // Check KiiUser is logged in
  if KiiUser.currentUser() == nil{
    return
  }
  
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
  let object = bucket.createObject()
  
  // Set key-value pairs.
  object.setObject("MyImage", forKey: "title")
  object.setObject(NSNumber(integer: 783204), forKey: "fileSize")
  
  object.saveWithBlock { (object , error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Prepare file to upload
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    
    let sourceFilePath = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
    let sourceFileURL = NSURL(fileURLWithPath: sourceFilePath)
    
    object.uploadBodyWithURL(sourceFileURL, andContentType: "image/jpeg", andCompletion: { (retObject, error ) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}