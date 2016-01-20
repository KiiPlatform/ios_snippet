//
//  ios_managing-data_object-storages_downloading_resume.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/downloading/resume

private func snippet_blocking(){
  // Create a bucket instance.
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
  // Get a KiiRTransferManager.
  let manager = bucket.transferManager()
  
  // Get all KiiDownloader instances.
  let downloadEntries : [KiiDownloader]
  do{
    downloadEntries = try manager.getDownloadEntries() as! [KiiDownloader]
  }catch(let error as NSError){
    // Error handling
    print(error.description)
    return
  }
  
  for downloader in downloadEntries {
    // If the download status is "suspended", try to resume the transfer.
    if downloader.info().status() == .RTStatus_SUSPENDED {
      var error : NSError?
      // Create a progress and completion blocks.
      let progress : KiiRTransferBlock = { (transferObject, error) in
        let info = transferObject.info()
        print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
      }
      // Resume the file download.
      downloader.transferWithProgressBlock(progress, andError: &error)
      if error != nil {
        // Error handling
        return
      }
    }
  }

}

private func snippet_non_blocking(){
  // Create a bucket instance.
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
  // Get a KiiRTransferManager.
  let manager = bucket.transferManager()
  
  // Get all KiiDownloader instances.
  let downloadEntries : [KiiDownloader]
  do{
    downloadEntries = try manager.getDownloadEntries() as! [KiiDownloader]
  }catch(let error as NSError){
    // Error handling
    print(error.description)
    return
  }
  
  for downloader in downloadEntries {
    // If the download status is "suspended", try to resume the transfer.
    if downloader.info().status() == .RTStatus_SUSPENDED {
      // Create a progress and completion blocks.
      let progress : KiiRTransferBlock = { (transferObject, error) in
        let info = transferObject.info()
        print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
      }
      let completion : KiiRTransferBlock = { (transferObject, error) in
        if error != nil {
          // Error handling
          return
        }
      }
      // Resume the file download.
      downloader.transferWithProgressBlock(progress, andCompletionBlock: completion)
    }
  }
}