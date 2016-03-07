//
//  ios_managing-data_object-storages_downloading.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/downloading/

//Downloading with Background Transfer
private func snippet_1_blocking(){
  class delegate :NSObject, NSURLSessionDataDelegate,NSURLSessionDownloadDelegate{
    //snippet start here
    func downloadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.currentUser() == nil{
        return
      }
      // Create the target Object instance
      let object = KiiObject(URI: "put existing object uri here")

      // Refresh the instance to get the latest key-values.

      do{
        try object.refreshSynchronous()
      } catch let error as NSError {
        print(error)
        print("Object refresh error!")
        return
      }

      // Prepare NSURLSession to download Object Body in background.
      let downloadRequest = object.generateDownloadRequest()
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
      // Create download task
      let downloadTask = session.downloadTaskWithRequest(downloadRequest)
      // Start/resume the task
      downloadTask.resume()
    }

    @objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      // Download progress
      print("Progress : \(Float(totalBytesWritten / totalBytesExpectedToWrite))")
    }

    @objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
      // Note: File downloaded location is in a temporary area. Move this temporary file to the persistent area if needed.

      // Specify target file path to move.
      let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
      let downloadFilePathStr = targetDirectory.stringByAppendingPathComponent("sample.mp4")
      let downloadFilePath = NSURL(fileURLWithPath: downloadFilePathStr)
      let fileManager = NSFileManager.defaultManager()

      do{
        try fileManager.moveItemAtURL(location, toURL: downloadFilePath)
      }catch (let error){
        print("File move is failed \(error)")
        return
      }
      print("Download succeeded")

    }

    @objc private func URLSession(session : NSURLSession, task: NSURLSessionTask, didCompleteWithError error : NSError?){
      if error != nil {
        // Error handling
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
  class delegate :NSObject, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate{
    //snippet start here

    func downloadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.currentUser() == nil{
        return
      }
      // Create the target Object instance
      let object = KiiObject(URI: "put existing object uri here")

      // Refresh the instance to get the latest key-values.
      object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
        if error != nil {
          print("Object refresh error!")
          return
        }

        // Prepare NSURLSession to download Object Body in background.
        let downloadRequest = object!.generateDownloadRequest()
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
        // Create download task
        let downloadTask = session.downloadTaskWithRequest(downloadRequest)
        // Start/resume the task
        downloadTask.resume()
      }
    }

    @objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      // Download progress
      print("Progress : \(Float(totalBytesWritten / totalBytesExpectedToWrite))")
    }

    @objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
      // Note: File downloaded location is in a temporary area. Move this temporary file to the persistent area if needed.

      // Specify target file path to move.
      let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
      let downloadFilePathStr = targetDirectory.stringByAppendingPathComponent("sample.mp4")
      let downloadFilePath = NSURL(fileURLWithPath: downloadFilePathStr)
      let fileManager = NSFileManager.defaultManager()

      do{
        try fileManager.moveItemAtURL(location, toURL: downloadFilePath)
      }catch (let error){
        print("File move is failed \(error)")
        return
      }
      print("Download succeeded")

    }

    @objc private func URLSession(session : NSURLSession, task: NSURLSessionTask, didCompleteWithError error : NSError?){
      if error != nil {
        // Error handling
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
//Downloading with resumable transfer
private func snippet_2_blocking(){
  // Create the target Object instance
  let object = KiiObject(URI: "put existing object uri here")

  // Refresh the instance to get the latest key-values.
  do{
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    print("Object refresh error!")
    // Error handling
    return
  }


  // Create a KiiDownloader.
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  let downloadFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
  let downloader = object.downloader(downloadFilePath)

  // Create a progress block.
  let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error : NSError?) in
    let info = transferObject.info()
    print("Progress : \(Float(info!.completedSizeInBytes()/info!.totalSizeInBytes()))")
  }

  // Start downloading.
  do{
    try downloader.transferWithProgressBlock(progress)
  } catch let error as NSError {
    print(error)
    print("transfer error")
    return
  }

}
private func snippet_2_non_blocking(){
  // Create the target Object instance
  let object = KiiObject(URI: "put existing object uri here")

  object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Create a KiiDownloader.
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    let downloadFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
    let downloader = object!.downloader(downloadFilePath)

    // Create a progress block.
    let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error : NSError?) in
      let info = transferObject.info()
      print("Progress : \(Float(info!.completedSizeInBytes()/info!.totalSizeInBytes()))")
    }

    downloader.transferWithProgressBlock(progress, andCompletionBlock: { (transferObject : KiiRTransfer, error : NSError?) in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}
//Downloading without resumable transfer
private func snippet_3_blocking(){
  // Create the target Object instance
  let object = KiiObject(URI: "put existing object uri here")

  // Refresh the instance to get the latest key-values.
  do{
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    print("Object refresh error!")
    return
  }

  // Prepare file to download
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
  let downloadFilePathStr = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
  let downloadFilePath = NSURL(fileURLWithPath: downloadFilePathStr)

  // Start downloading Object Body
  do{
    try object.downloadBodySynchronousWithURL(downloadFilePath)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_3_non_blocking(){
  let object = KiiObject(URI: "put existing object uri here")

  object.refreshWithBlock { (object : KiiObject?, error : NSError?) -> Void in
    if error != nil {
      // Error handling
      print("Object refresh error!")
      return
    }
    // Prepare file to download
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    let downloadFilePathStr = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
    let downloadFilePath = NSURL(fileURLWithPath: downloadFilePathStr)

    // Start downloading Object Body
    object!.downloadBodyWithURL(downloadFilePath, andCompletion: { (object : KiiObject?, error : NSError?) -> Void in
      if error != nil {
        // Error handling
        print("Transfer error!")
        return
      }
    })
  }
}
