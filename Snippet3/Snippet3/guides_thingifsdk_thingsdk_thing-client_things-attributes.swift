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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error  as Any)
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

  do{
    try thing.updateSynchronous()
  } catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }

}
private func snippet_1_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    thing!.thingType = "GPS"
    thing!.vendor = "Kii Corporation"
    thing!.firmwareVersion = "1.01"
    thing!.productName = "KiiCloud"
    thing!.lot = "KII20140711-AB-002134D"
    thing!.stringField1 = "S001"
    thing!.stringField2 = "S002"
    thing!.stringField3 = "S003"
    thing!.stringField4 = "S004"
    thing!.stringField5 = "S005"
    thing!.numberField1 = 101
    thing!.numberField2 = 102
    thing!.numberField3 = 103
    thing!.numberField4 = 104
    thing!.numberField5 = 105

    thing!.update({ (thing , error) -> Void in
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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error  as Any)
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
  print(thingType  as Any)
  print(vendor  as Any)
  print(firmwareVersion  as Any)
  print(productName  as Any)
  print(lot  as Any)
  print(stringField1  as Any)
  print(stringField2  as Any)
  print(stringField3  as Any)
  print(stringField4  as Any)
  print(stringField5  as Any)
  print(numberField1  as Any)
  print(numberField2  as Any)
  print(numberField3  as Any)
  print(numberField4  as Any)
  print(numberField5  as Any)
}
private func snippet_2_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let thingType = thing!.thingType
    let vendor = thing!.vendor
    let firmwareVersion = thing!.firmwareVersion
    let productName = thing!.productName
    let lot = thing!.lot
    let stringField1 = thing!.stringField1
    let stringField2 = thing!.stringField2
    let stringField3 = thing!.stringField3
    let stringField4 = thing!.stringField4
    let stringField5 = thing!.stringField5
    let numberField1 = thing!.numberField1
    let numberField2 = thing!.numberField2
    let numberField3 = thing!.numberField3
    let numberField4 = thing!.numberField4
    let numberField5 = thing!.numberField5
    //dummy just to silence warning
    print(thingType  as Any)
    print(vendor  as Any)
    print(firmwareVersion  as Any)
    print(productName  as Any)
    print(lot  as Any)
    print(stringField1  as Any)
    print(stringField2  as Any)
    print(stringField3  as Any)
    print(stringField4  as Any)
    print(stringField5  as Any)
    print(numberField1  as Any)
    print(numberField2  as Any)
    print(numberField3  as Any)
    print(numberField4  as Any)
    print(numberField5  as Any)
  }
}

// Setting Custom Fields
private func snippet_3_blocking(){
  let thing : KiiThing
  do{
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error  as Any)
    return
  }
  thing.setObject("K00001233214001", forKey: "serial_number")

  thing.update({ (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
  })

}
private func snippet_3_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }

    thing!.setObject("K00001233214001", forKey: "serial_number")

    thing!.update({ (thing , error) -> Void in
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
    thing = try KiiThing.loadSynchronous(withVendorThingID: "rBnvSPOXBDF9r29GJeGS")
  }catch(let error as NSError){
    // Error handling
    print(error  as Any)
    return
  }
  let serialNumber = thing.getForKey("serialNumber") as! String
  let accuracy = thing.getForKey("accuracy") as! Double
  let version = thing.getForKey("version") as! Int
  let isInitialized = thing.getForKey("isInitialized") as! Bool

  print(serialNumber,accuracy,version,isInitialized)
}
private func snippet_4_non_blocking(){
  KiiThing.load(withVendorThingID: "rBnvSPOXBDF9r29GJeGS") { (thing , error) -> Void in
    if error != nil {
      // Error handling
      return
    }
    let serialNumber = thing!.getForKey("serialNumber") as! String
    let accuracy = thing!.getForKey("accuracy") as! Double
    let version = thing!.getForKey("version") as! Int
    let isInitialized = thing!.getForKey("isInitialized") as! Bool

    print(serialNumber,accuracy,version,isInitialized)
  }
}
