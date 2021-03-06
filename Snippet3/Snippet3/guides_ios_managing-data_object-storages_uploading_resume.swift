//
//  ios_managing-data_object-storages_uploading_resume.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path : en/guides/ios/managing-data/object-storages/uploading/resume

private func snippet_blocking(){
  let bucket = KiiUser.current()!.bucket(withName: "bucket001")
  // Get a KiiRTransferManager.
  let manager = bucket.transferManager()
  
  // Get all KiiUploader instances.
  let uploadEntries : [KiiUploader]
  do{
    uploadEntries = try manager.getDownloadEntries() as! [KiiUploader]
  }catch(let error as NSError){
    // Error handling
    print(error.description)
    return
  }
  
  for uploader in uploadEntries {
    // If the upload status is "suspended", try to resume the transfer.
    if uploader.info().status() == .rtStatus_SUSPENDED {
      // Create a progress and completion blocks.
      let progress : KiiRTransferBlock = { (transferObject : KiiRTransfer, error ) in
        let info = transferObject.info()
        print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
      }
      // Resume the file upload.
      do{
        try uploader.transfer(progressBlock: progress)
      } catch let error as NSError {
        print(error.description)
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
  
  // Get all KiiUploader instances.
  let uploadEntries : [KiiUploader]
  do{
    uploadEntries = try manager.getDownloadEntries() as! [KiiUploader]
  }catch(let error as NSError){
    // Error handling
    print(error.description)
    return
  }
  
  for uploader in uploadEntries {
    // If the upload status is "suspended", try to resume the transfer.
    if uploader.info().status() == .rtStatus_SUSPENDED {
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
      
      // Resume the file upload.
      uploader.transfer(progressBlock: progress, andCompletionBlock: completion)
    }
  }
}
