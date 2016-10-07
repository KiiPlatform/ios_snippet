//
//  managing-users_user-attributes.swift
//  Snippet
//
//  Created by syahRiza on 12/14/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

// MARK: path /guides/ios/managing-users/user-attributes/

//The following example illustrates how to set the predefined fields.

private func snippet_1_blocking(){
  // Get the currently logged in user.
  let builder = KiiIdentityDataBuilder()
  builder.userName = "My_New_Name"
  builder.email = "myNewEmail@example.com"
  builder.phoneNumber = "+15555555555"
  let identityData : KiiIdentityData
  do{
    identityData = try builder.buildWithError()
    let userFields = KiiUserFields()
    userFields.displayName = "My_New_Name"
    userFields.country = "JP"
    userFields.locale = LocaleContainer()

    let user = KiiUser.current()!
    // Set display name and country.

    try user.update(withIdentityDataSynchronous: identityData, userFields: userFields)
  }catch (let retError as NSError){
    print(retError.description)
    // Error handling
    return
  }

}

private func snippet_1_non_blocking(){
  // Get the currently logged in user.
  let builder = KiiIdentityDataBuilder()
  builder.userName = "My_New_Name"
  builder.email = "myNewEmail@example.com"
  builder.phoneNumber = "+15555555555"
  
  let identityData : KiiIdentityData
  do{
    identityData = try builder.buildWithError()
  }catch (let retError as NSError){
    print(retError.description)
    // Error handling
    return
  }
  let userFields = KiiUserFields()
  userFields.displayName = "My_New_Name"
  userFields.country = "JP"
  userFields.locale = LocaleContainer()

  let user = KiiUser.current()!
  
  user.update(with: identityData, userFields: userFields) { (retUser :KiiUser?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Example of getting the predefined fields
private func snippet_2(){
  let user = KiiUser.current()!
  // Get the user attributes.
  let userName = user.username
  let emailAddress = user.email
  let phoneNumber = user.phoneNumber
  let displayName = user.displayName
  let country = user.country
  let locale = user.locale
  
  //dummy just to silence warning
  print(userName,emailAddress,phoneNumber,displayName,country, locale)
}

//Example of setting the custom fields

private func snippet_3_blocking(){
  // Set some custom fields.
  let userFields = KiiUserFields()
  userFields.setObject(NSNumber(value: 20 as Int32), forKey: "age")
  userFields.setObject("male", forKey: "gender")
  userFields.setObject(NSNumber(value: 170.5 as Float), forKey: "height")
  userFields.setObject(NSNumber(value: true as Bool), forKey: "isMember")
  
  // Remove some custom fields
  userFields.removeFromServer(forKey: "weight")
  userFields.removeFromServer(forKey: "chest")
  
  let user = KiiUser.current()!
  do {
    try user.update(withUserFieldsSynchronous: userFields)
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_3_non_blocking(){
  // Set some custom fields.
  let userFields = KiiUserFields()
  userFields.setObject(NSNumber(value: 20 as Int32), forKey: "age")
  userFields.setObject("male", forKey: "gender")
  userFields.setObject(NSNumber(value: 170.5 as Float), forKey: "height")
  userFields.setObject(NSNumber(value: true as Bool), forKey: "isMember")
  
  // Remove some custom fields
  userFields.removeFromServer(forKey: "weight")
  userFields.removeFromServer(forKey: "chest")
  
  let user = KiiUser.current()!
  user.update(with: userFields) { (retUser :KiiUser?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Example of getting the custom fields

private func snippet_4(){
  let user = KiiUser.current()!
  // Get some custom fields.
  let age = (user.getObjectForKey("age") as! NSNumber).intValue
  let gender = user.getObjectForKey("gender") as! String
  let height = (user.getObjectForKey("height") as! NSNumber).floatValue
  let isMember = (user.getObjectForKey("isMember") as! NSNumber).boolValue
  
  //dummy just for silence warning
  print(age,gender,height,isMember)
}

//Example of setting the custom fields upon the user registration

private func snippet_4_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  
  let user = KiiUser(username: username, andPassword: password)

  // Initialize the custom attributes
  user.setObject(NSNumber(value: 30 as Int32), forKey: "age")
  user.setObject(NSNumber(value: 0 as Int32), forKey: "score")
  
  do {
    try user.performRegistrationSynchronous()
  } catch let error as NSError {
    print(error)
    // Error handling
    return
  }

}

private func snippet_4_non_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  
  let user = KiiUser(username: username, andPassword: password)
  
  // Initialize the custom attributes
  user.setObject(NSNumber(value: 30 as Int32), forKey: "age")
  user.setObject(NSNumber(value: 0 as Int32), forKey: "score")
  
  user.performRegistration { (retUser :KiiUser?, error : Error?) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
