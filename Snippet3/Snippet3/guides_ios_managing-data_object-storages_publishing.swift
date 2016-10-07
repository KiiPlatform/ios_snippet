//
//  ios_managing-data_object-storages_publishing.swift
//  Snippet
//
//  Created by syahRiza on 12/15/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path : en/guides/ios/managing-data/object-storages/publishing/
private let object = KiiObject(uri: "dummy")
//To publish a file without any expiration time
private func snippet_1_blocking(){
  // Assume that let object : KiiObject is already set.
  do{
    let url = try object!.publishBodySynchronous()
    //dummy
    print(url)
  }catch(let error as NSError){
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_1_non_blocking(){
  // Assume that let object : KiiObject is already set.
  object!.publishBody{ (object : KiiObject , url : String?, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    print(url)
  }
  
}

//To publish a file for the designated time duration
private func snippet_2_blocking(){
  // Assume that let object : KiiObject is already set.
  do{
    let time : UInt = 60 * 60
    let url = try object!.publishBodySynchronousExpires(in: time)
    //dummy
    print(url)
  }catch(let error as NSError){
    print(error.description)
    // Error handling
    return
  }
}
private func snippet_2_non_blocking(){
  // Assume that let object : KiiObject is already set.
  let time : UInt = 60 * 60
  object!.publishBodyExpires(in: time){ (object : KiiObject , url : String?, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    print(url)
  }
}

//To publish a file until the designated date&time
private func snippet_3_blocking(){
  // Assume that let object : KiiObject is already set.
  var components = DateComponents()
  components.year = 2099
  components.month = 12
  components.day = 31
  components.hour = 23
  components.minute = 59
  components.second = 59
  (components as NSDateComponents).calendar = Calendar.current
  let date = (components as NSDateComponents).date!
  do{
    let url = try object!.publishBodySynchronousExpires(at: date)
    //dummy
    print(url)
  }catch(let error as NSError){
    print(error.description)
    // Error handling
    return
  }
}
private func snippet_3_non_blocking(){
  // Assume that let object : KiiObject is already set.
  var components = DateComponents()
  components.year = 2099
  components.month = 12
  components.day = 31
  components.hour = 23
  components.minute = 59
  components.second = 59
  (components as NSDateComponents).calendar = Calendar.current
  let date = (components as NSDateComponents).date!
  
  object!.publishBodyExpires(at: date) { (object : KiiObject , url : String?, error : Error? ) -> Void in
    if error != nil {
      // Error handling
      return
    }
    print(url)
  }
  
}
