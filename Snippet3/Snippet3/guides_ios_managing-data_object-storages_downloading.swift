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
  class delegate :NSObject, URLSessionDataDelegate,URLSessionDownloadDelegate{
    //snippet start here
    func downloadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.current() == nil{
        return
      }
      // Create the target Object instance
      let object = KiiObject(uri: "put existing object uri here")!

      // Refresh the instance to get the latest key-values.

      do{
        try object.refreshSynchronous()
      } catch let error as NSError {
        print(error)
        print("Object refresh error!")
        return
      }

      // Prepare NSURLSession to download Object Body in background.
      let downloadRequest = object.generateDownloadRequest()!
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
      // Create download task
      let downloadTask = session.downloadTask(with: downloadRequest)
      // Start/resume the task
      downloadTask.resume()
    }

    @objc fileprivate func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      // Download progress
      print("Progress : \(Float(totalBytesWritten / totalBytesExpectedToWrite))")
    }

    @objc fileprivate func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      // Note: File downloaded location is in a temporary area. Move this temporary file to the persistent area if needed.

      // Specify target file path to move.
      let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
      let downloadFilePathStr = targetDirectory.appendingPathComponent("sample.mp4")
      let downloadFilePath = URL(fileURLWithPath: downloadFilePathStr)
      let fileManager = FileManager.default

      do{
        try fileManager.moveItem(at: location, to: downloadFilePath)
      }catch (let error){
        print("File move is failed \(error)")
        return
      }
      print("Download succeeded")

    }

    @objc fileprivate func urlSession(_ session : URLSession, task: URLSessionTask, didCompleteWithError error: Error? ){
      if error != nil {
        // Error handling
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
  class delegate :NSObject, URLSessionDataDelegate, URLSessionDownloadDelegate{
    //snippet start here

    func downloadObjectBody(){
      // Check KiiUser is logged in
      if KiiUser.current() == nil{
        return
      }
      // Create the target Object instance
      let object = KiiObject(uri: "put existing object uri here")!

      // Refresh the instance to get the latest key-values.
      object.refresh { (object : KiiObject?, error : Error?) -> Void in
        if error != nil {
          print("Object refresh error!")
          return
        }

        // Prepare NSURLSession to download Object Body in background.
        let downloadRequest = object!.generateDownloadRequest()!
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
        // Create download task
        let downloadTask = session.downloadTask(with: downloadRequest)
        // Start/resume the task
        downloadTask.resume()
      }
    }

    @objc fileprivate func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      // Download progress
      print("Progress : \(Float(totalBytesWritten / totalBytesExpectedToWrite))")
    }

    @objc fileprivate func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      // Note: File downloaded location is in a temporary area. Move this temporary file to the persistent area if needed.

      // Specify target file path to move.
      let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
      let downloadFilePathStr = targetDirectory.appendingPathComponent("sample.mp4")
      let downloadFilePath = URL(fileURLWithPath: downloadFilePathStr)
      let fileManager = FileManager.default

      do{
        try fileManager.moveItem(at: location, to: downloadFilePath)
      }catch (let error){
        print("File move is failed \(error)")
        return
      }
      print("Download succeeded")

    }

    @objc fileprivate func urlSession(_ session : URLSession, task: URLSessionTask, didCompleteWithError error: Error? ){
      if error != nil {
        // Error handling
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
//Downloading with resumable transfer
private func snippet_2_blocking(){
  // Create the target Object instance
  let object = KiiObject(uri: "put existing object uri here")!

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
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
  let downloadFilePath = targetDirectory.appendingPathComponent("sample.mp4")
  let downloader = object.downloader(downloadFilePath)

  // Create a progress block.
  let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
    let info = transferObject.info()
    print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
  }

  // Start downloading.
  do{
    try downloader.transfer(progressBlock: progress)
  } catch let error as NSError {
    print(error)
    print("transfer error")
    return
  }

}
private func snippet_2_non_blocking(){
  // Create the target Object instance
  let object = KiiObject(uri: "put existing object uri here")!

  object.refresh { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
    // Create a KiiDownloader.
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
    let downloadFilePath = targetDirectory.appendingPathComponent("sample.mp4")
    let downloader = object!.downloader(downloadFilePath)

    // Create a progress block.
    let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
      let info = transferObject.info()
      print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
    }

    downloader.transfer(progressBlock: progress, andCompletionBlock: { (transferObject : KiiRTransfer, error ) in
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
  let object = KiiObject(uri: "put existing object uri here")!

  // Refresh the instance to get the latest key-values.
  do{
    try object.refreshSynchronous()
  } catch let error as NSError {
    print(error)
    print("Object refresh error!")
    return
  }

  // Prepare file to download
  let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
  let downloadFilePathStr = targetDirectory.appendingPathComponent("myImage.jpg")
  let downloadFilePath = URL(fileURLWithPath: downloadFilePathStr)

  // Start downloading Object Body
  do{
    try object.downloadBodySynchronous(with: downloadFilePath)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_3_non_blocking(){
  let object = KiiObject(uri: "put existing object uri here")!

  object.refresh { (object : KiiObject?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      print("Object refresh error!")
      return
    }
    // Prepare file to download
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).appendingPathComponent("Documents") as NSString
    let downloadFilePathStr = targetDirectory.appendingPathComponent("myImage.jpg")
    let downloadFilePath = URL(fileURLWithPath: downloadFilePathStr)

    // Start downloading Object Body
    object!.downloadBody(with: downloadFilePath, andCompletion: { (object : KiiObject?, error : Error?) -> Void in
      if error != nil {
        // Error handling
        print("Transfer error!")
        return
      }
    })
  }
}
