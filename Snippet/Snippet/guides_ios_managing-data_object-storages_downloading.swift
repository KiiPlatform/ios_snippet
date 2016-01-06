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
            
            let downloadRequest = object.generateUploadRequest(contentType)
            
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
            print("Progress : \(Float(totalBytesWritten / totalBytesExpectedToWrite))")
        }
        @objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
            // Prepare file to download
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
    class delegate :NSObject, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate{
        //snippet start here
        
        func downloadObjectBody(){
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
                
                let downloadRequest = object.generateUploadRequest(contentType)
                
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
            print("Progress : \(Float(totalBytesWritten / totalBytesExpectedToWrite))")
        }
        @objc private func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
            // Prepare file to download
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
//Downloading with resumable transfer
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
    
    // Prepare file to download
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    
    let downloadFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
    
    let downloader = object.downloader(downloadFilePath)
    let progress : KiiRTransferBlock = { (transferObject, error ) in
        let info = transferObject.info()
        print("Progress : \(Float(info.completedSizeInBytes()/info.totalSizeInBytes()))")
    }
    
    downloader.transferWithProgressBlock(progress, andError: &error)
    
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
        // Prepare file to download
        let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
        
        let downloadFilePath = targetDirectory.stringByAppendingPathComponent("sample.mp4")
        
        let downloader = object.downloader(downloadFilePath)
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
        downloader.transferWithProgressBlock(progress, andCompletionBlock: completion)
        
    }
    
}
//Downloading without resumable transfer
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
    
    // Prepare file to download
    let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
    
    let downloadFilePathStr = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
    let downloadFilePath = NSURL(fileURLWithPath: downloadFilePathStr)
    object.downloadBodySynchronousWithURL(downloadFilePath, andError: &error)
    
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
        // Prepare file to download
        let targetDirectory : NSString = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
        
        let downloadFilePathStr = targetDirectory.stringByAppendingPathComponent("myImage.jpg")
        let downloadFilePath = NSURL(fileURLWithPath: downloadFilePathStr)
        
        object.downloadBodyWithURL(downloadFilePath, andCompletion: { (object , error) -> Void in
            if error != nil {
                // Error handling
                return
            }
        })
    }
}
