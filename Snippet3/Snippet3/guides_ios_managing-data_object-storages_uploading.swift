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
  class delegate :NSObject, URLSessionDataDelegate{
    //snippet start here
    func uploadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.current() == nil{
        return
      }

      // Create an object in a user-scope bucket.
      let bucket = KiiUser.current()!.bucket(withName: "bucket001")
      let object = bucket.createObject()

      // Set key-value pairs.
      object.setObject("myVideo", forKey: "title")
      object.setObject(NSNumber(value: 10485760 as Int), forKey: "fileSize")

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
      let uuidStr = UUID().uuidString
      let randomSessionIdentifier = uuidStr.lowercased()
      let sessionConfig : URLSessionConfiguration
      if #available(iOS 8, *) {
        sessionConfig = URLSessionConfiguration.background(withIdentifier: randomSessionIdentifier)
      }else{
        sessionConfig = URLSessionConfiguration.backgroundSessionConfiguration(randomSessionIdentifier)
      }
      sessionConfig.allowsCellularAccess = true
      let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)

      // Prepare file to upload
      let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
      let sourceFilePath = targetDirectory.appendingPathComponent("sample.mp4")
      let sourceFileURL = URL(fileURLWithPath: sourceFilePath)

      // Create upload task
      let uploadTask = session.uploadTask(with: uploadRequest, fromFile: sourceFileURL)

      // Start/resume the task
      uploadTask.resume()
    }

    @objc fileprivate func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
      // Upload progress
      print("Progress : \(Float(totalBytesSent / totalBytesExpectedToSend))")
    }

    @objc fileprivate func urlSession(_ session : URLSession, task: URLSessionTask, didCompleteWithError error: Error? ){
      if error != nil {
        // Something went wrong...
        print("Background transfer is failed")
        return
      }
      // Also check http status code
      let response = task.response as! HTTPURLResponse
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
  class delegate :NSObject, URLSessionDataDelegate{
    //snippet start here

    func uploadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.current() == nil{
        return
      }

      // Create an object in a user-scope bucket.
      let bucket = KiiUser.current()!.bucket(withName: "bucket001")
      let object = bucket.createObject()

      // Set key-value pairs.
      object.setObject("myVideo", forKey: "title")
      object.setObject(NSNumber(value: 10485760 as Int), forKey: "fileSize")

      // Save KiiObject
      object.save { (object : KiiObject?, error : Error? ) -> Void in
        if error != nil {
          print("Object creation error!")
          return
        }

        // Prepare NSURLSession to upload Object Body in a background.
        let contentType = "video/mp4"
        let uploadRequest = object!.generateUploadRequest(contentType)!
        let uuidStr = UUID().uuidString
        let randomSessionIdentifier = uuidStr.lowercased()
        let sessionConfig : URLSessionConfiguration
        if #available(iOS 8, *) {
          sessionConfig = URLSessionConfiguration.background(withIdentifier: randomSessionIdentifier)
        }else{
          sessionConfig = URLSessionConfiguration.backgroundSessionConfiguration(randomSessionIdentifier)
        }
        sessionConfig.allowsCellularAccess = true
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)

        // Prepare file to upload
        let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
        let sourceFilePath = targetDirectory.appendingPathComponent("sample.mp4")
        let sourceFileURL = URL(fileURLWithPath: sourceFilePath)

        // Create upload task
        let uploadTask = session.uploadTask(with: uploadRequest, fromFile: sourceFileURL)
        // Start/resume the task
        uploadTask.resume()
      }

    }

    @objc fileprivate func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
      // Upload progress
      print("Progress : \(Float(totalBytesSent / totalBytesExpectedToSend))")
    }

    @objc fileprivate func urlSession(_ session : URLSession, task: URLSessionTask, didCompleteWithError error: Error? ){
      if error != nil {
        // Something went wrong...
        print("Background transfer is failed")
        return
      }
      // Also check http status code
      let response = task.response as! HTTPURLResponse
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
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("myVideo", forKey: "title")
  object.setObject(NSNumber(value: 10485760 as Int), forKey: "fileSize")

  // Create an uploader.
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
  let sourceFilePath = targetDirectory.appendingPathComponent("sample.mp4")

  let uploader = object.uploader(sourceFilePath)

  // Create a progress block.
  let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
    let info = transferObject.info()
    print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
  }

  // Start uploading.
  do{
    try uploader.transfer(progressBlock: progress)
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_2_non_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("myVideo", forKey: "title")
  object.setObject(NSNumber(value: 10485760 as Int), forKey: "fileSize")

  // Create an uploader.
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
  let sourceFilePath = targetDirectory.appendingPathComponent("sample.mp4")
  let uploader = object.uploader(sourceFilePath)

  // Create a progress block.
  let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
    let info = transferObject.info()
    print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
  }
  // Start uploading.
  uploader.transfer(progressBlock: progress, andCompletionBlock: { (transferObject : KiiRTransfer, error ) in
    if error != nil {
      // Error handling
      return
    }
  })
}
//Uploading without resumable transfer
private func snippet_3_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("MyImage", forKey: "title")
  object.setObject(NSNumber(value: 783204 as Int), forKey: "fileSize")

  // Save KiiObject

  do{
    try object.saveSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

  // Prepare file to upload
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
  let sourceFilePath = targetDirectory.appendingPathComponent("myImage.jpg")
  let sourceFileURL = URL(fileURLWithPath: sourceFilePath)

  // Start uploading.
  do{
    try object.uploadBodySynchronous(with: sourceFileURL, andContentType: "image/jpeg")
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_3_non_blocking(){
  // Create an object in a user-scope bucket.
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
  let object = bucket.createObject()

  // Set key-value pairs.
  object.setObject("MyImage", forKey: "title")
  object.setObject(NSNumber(value: 783204 as Int), forKey: "fileSize")

  object.save { (object : KiiObject?, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Prepare file to upload
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
    let sourceFilePath = targetDirectory.appendingPathComponent("myImage.jpg")
    let path = URL(fileURLWithPath: sourceFilePath)

    // Start uploading.
    object!.uploadBody(with: path, andContentType: "image/jpeg", andCompletion: { (retObject : KiiObject?, error : Error? ) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
