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
      let bucket = KiiUser.currentUser()!.bucketWithName("bucket001")
      let object = bucket.createObject()

      // Set key-value pairs.
      object.setObject("myVideo", forKey: "title")
      object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")

      // Save KiiObject
      do{
        try object.saveSynchronous()
      } catch let error as NSError {
        print(error.description)
        // Error handling
        return
      }

      // Prepare NSURLSession to upload Object Body in a background.
      let contentType = "video/mp4"
      let uploadRequest = object.generateUploadRequest(contentType)!
      let uuidStr = NSUUID().UUIDString
      let randomSessionIdentifier = uuidStr.lowercaseString
      let sessionConfig : NSURLSessionConfiguration
      sessionConfig = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(randomSessionIdentifier)
      
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
      // Upload progress
      print("Progress : \(Float(totalBytesSent / totalBytesExpectedToSend))")
    }

    @objc private func URLSession(session : NSURLSession, task: NSURLSessionTask, didCompleteWithError error : NSError?){
      if error != nil {
        // Something went wrong...
        print("Background transfer is failed")
        return
      }
      // Also check http status code
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
      let bucket = KiiUser.currentUser()!.bucketWithName("bucket001")
      let object = bucket.createObject()

      // Set key-value pairs.
      object.setObject("myVideo", forKey: "title")
      object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")

      // Save KiiObject
      object.saveWithBlock { (object : KiiObject?, error : NSError?) -> Void in
        if error != nil {
          print("Object creation error!")
          return
        }

        // Prepare NSURLSession to upload Object Body in a background.
        let contentType = "video/mp4"
        let uploadRequest = object!.generateUploadRequest(contentType)!
        let uuidStr = NSUUID().UUIDString
        let randomSessionIdentifier = uuidStr.lowercaseString
        let sessionConfig : NSURLSessionConfiguration
        sessionConfig = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(randomSessionIdentifier)
        
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
      // Upload progress
      print("Progress : \(Float(totalBytesSent / totalBytesExpectedToSend))")
    }

    @objc private func URLSession(session : NSURLSession, task: NSURLSessionTask, didCompleteWithError error : NSError?){
      if error != nil {
        // Something went wrong...
        print("Background transfer is failed")
        return
      }
      // Also check http status code
      let response = task.response as! NSHTTPURLResponse
      if response.statusCode >= 300 {
        print("Background transfer is failed, status code: \(response.statusCode)")
        return
      }
      print("Background transfer is success")
    }
  }
}
//Uploading with resumable transfer
private func snippet_2_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser()!.bucketWithName("bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("myVideo", forKey: "title")
  object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")

  // Create an uploader.
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  let sourceFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")

  let uploader = object.uploader(sourceFilePath)

  // Create a progress block.
  let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error : NSError?) in
    let info = transferObject.info()
    print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
  }

  // Start uploading.
  do{
    try uploader.transferWithProgressBlock(progress)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_2_non_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser()!.bucketWithName("bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("myVideo", forKey: "title")
  object.setObject(NSNumber(integer: 10485760), forKey: "fileSize")

  // Create an uploader.
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  let sourceFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
  let uploader = object.uploader(sourceFilePath)

  // Create a progress block.
  let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error : NSError?) in
    let info = transferObject.info()
    print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
  }
  // Start uploading.
  uploader.transferWithProgressBlock(progress, andCompletionBlock: { (transferObject : KiiRTransfer, error : NSError?) in
    if error != nil {
      // Error handling
      return
    }
  })
}
//Uploading without resumable transfer
private func snippet_3_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser()!.bucketWithName("bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("MyImage", forKey: "title")
  object.setObject(NSNumber(integer: 783204), forKey: "fileSize")

  // Save KiiObject

  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  // Prepare file to upload
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  let sourceFilePath = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
  let sourceFileURL = NSURL(fileURLWithPath: sourceFilePath)

  // Start uploading.
  do{
    try object.uploadBodySynchronousWithURL(sourceFileURL, andContentType: "image/jpeg")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_3_non_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.currentUser()!.bucketWithName("bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("MyImage", forKey: "title")
  object.setObject(NSNumber(integer: 783204), forKey: "fileSize")

  object.saveWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Prepare file to upload
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    let sourceFilePath = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
    let path = NSURL(fileURLWithPath: sourceFilePath)

    // Start uploading.
    object!.uploadBodyWithURL(path, andContentType: "image/jpeg", andCompletion: { (retObject : KiiObject?, error : NSError?) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
