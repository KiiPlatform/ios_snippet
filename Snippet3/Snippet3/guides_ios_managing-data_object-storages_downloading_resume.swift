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
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
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
    if downloader.info().status() == .rtStatus_SUSPENDED {
      // Create a progress and completion blocks.
      let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
        let info = transferObject.info()
        print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
      }
      // Resume the file download.
      do {
        try downloader.transfer(progressBlock: progress)
      } catch let error as NSError {
        print(error  as Any)
        // Error handling
        return
      }
      
    }
  }

}

private func snippet_non_blocking(){
  // Create a bucket instance.
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
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
    if downloader.info().status() == .rtStatus_SUSPENDED {
      // Create a progress and completion blocks.
      let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
        let info = transferObject.info()
        print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
      }
      let completion : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
        if error != nil {
          // Error handling
          return
        }
      }
      // Resume the file download.
      downloader.transfer(progressBlock: progress, andCompletionBlock: completion)
    }
  }
}
