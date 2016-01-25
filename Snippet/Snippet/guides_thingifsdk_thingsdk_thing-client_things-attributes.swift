//
//  guides_thingifsdk_thingsdk_thing-client_things-attributes.swift
//  Snippet
//
//  Created by syahRiza on 12/17/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation
// MARK: path guides/thingifsdk/thingsdk/thing-client/things-attributes
// Setting Predefined Fields
private func snippet_1_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  thing.thingType = "GPS"
  thing.vendor = "Kii Corporation"
  thing.firmwareVersion = "1.01"
  thing.productName = "KiiCloud"
  thing.lot = "KII20140711-AB-002134D"
  thing.stringField1 = "S001"
  thing.stringField2 = "S002"
  thing.stringField3 = "S003"
  thing.stringField4 = "S004"
  thing.stringField5 = "S005"
  thing.numberField1 = 101
  thing.numberField2 = 102
  thing.numberField3 = 103
  thing.numberField4 = 104
  thing.numberField5 = 105
  
  var error : NSError?
  thing.updateSynchronous(&error)
  if error != nil {
    // Error handling
    return
  }
}
private func snippet_1_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing.thingType = "GPS"
    thing.vendor = "Kii Corporation"
    thing.firmwareVersion = "1.01"
    thing.productName = "KiiCloud"
    thing.lot = "KII20140711-AB-002134D"
    thing.stringField1 = "S001"
    thing.stringField2 = "S002"
    thing.stringField3 = "S003"
    thing.stringField4 = "S004"
    thing.stringField5 = "S005"
    thing.numberField1 = 101
    thing.numberField2 = 102
    thing.numberField3 = 103
    thing.numberField4 = 104
    thing.numberField5 = 105
    
    thing.update({ (thing, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
    
  }
}

// Getting Predefined Fields
private func snippet_2_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let thingType = thing.thingType
  let vendor = thing.vendor
  let firmwareVersion = thing.firmwareVersion
  let productName = thing.productName
  let lot = thing.lot
  let stringField1 = thing.stringField1
  let stringField2 = thing.stringField2
  let stringField3 = thing.stringField3
  let stringField4 = thing.stringField4
  let stringField5 = thing.stringField5
  let numberField1 = thing.numberField1
  let numberField2 = thing.numberField2
  let numberField3 = thing.numberField3
  let numberField4 = thing.numberField4
  let numberField5 = thing.numberField5
  
  //dummy just to silence warning
  print(thingType)
  print(vendor)
  print(firmwareVersion)
  print(productName)
  print(lot)
  print(stringField1)
  print(stringField2)
  print(stringField3)
  print(stringField4)
  print(stringField5)
  print(numberField1)
  print(numberField2)
  print(numberField3)
  print(numberField4)
  print(numberField5)
}
private func snippet_2_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingType = thing.thingType
    let vendor = thing.vendor
    let firmwareVersion = thing.firmwareVersion
    let productName = thing.productName
    let lot = thing.lot
    let stringField1 = thing.stringField1
    let stringField2 = thing.stringField2
    let stringField3 = thing.stringField3
    let stringField4 = thing.stringField4
    let stringField5 = thing.stringField5
    let numberField1 = thing.numberField1
    let numberField2 = thing.numberField2
    let numberField3 = thing.numberField3
    let numberField4 = thing.numberField4
    let numberField5 = thing.numberField5
    //dummy just to silence warning
    print(thingType)
    print(vendor)
    print(firmwareVersion)
    print(productName)
    print(lot)
    print(stringField1)
    print(stringField2)
    print(stringField3)
    print(stringField4)
    print(stringField5)
    print(numberField1)
    print(numberField2)
    print(numberField3)
    print(numberField4)
    print(numberField5)
  }
}

// Setting Custom Fields
private func snippet_3_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  thing.setObject("K00001233214001", forKey: "serial_number")
  
  thing.update({ (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })
  
}
private func snippet_3_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    
    thing.setObject("K00001233214001", forKey: "serial_number")
    
    thing.update({ (thing, error) -> Void in
      if error != nil {
        // Error handling
        return
      }
    })
  }
}

// Getting Custom Fields
private func snippet_4_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronousWithVendorThingID("rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error)
    return
  }
  let serialNumber = thing.getObjectForKey("serialNumber") as! String
  let accuracy = thing.getObjectForKey("accuracy") as! Double
  let version = thing.getObjectForKey("version") as! Int
  let isInitialized = thing.getObjectForKey("isInitialized") as! Bool
  
  print(serialNumber,accuracy,version,isInitialized)
}
private func snippet_4_non_blocking(){
  KiiThing.loadWithVendorThingID("rBnvSPOXBDF9r29GJeGS") { (thing, error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let serialNumber = thing.getObjectForKey("serialNumber") as! String
    let accuracy = thing.getObjectForKey("accuracy") as! Double
    let version = thing.getObjectForKey("version") as! Int
    let isInitialized = thing.getObjectForKey("isInitialized") as! Bool
    
    print(serialNumber,accuracy,version,isInitialized)
  }
}
