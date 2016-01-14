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
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
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
    var error : NSError?
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
}

private func snippet_non_blocking(){
  let bucket = KiiUser.currentUser().bucketWithName("bucket001")
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