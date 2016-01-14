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
  
  var error : NSError?
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
  
  let user = KiiUser.currentUser()
  
  user.updateWithIdentityDataSynchronous(identityData, userFields: userFields, error: &error)
  
  if error != nil {
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
  
  let user = KiiUser.currentUser()
  
  user.updateWithIdentityData(identityData, userFields: userFields) { (retUser, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Example of getting the predefined fields
private func snippet_2(){
  // Get the currently logged in user.
  let user = KiiUser.currentUser()
  
  let userName = user.username
  let emailAddress = user.email
  let phoneNumber = user.phoneNumber
  let displayName = user.displayName
  let country = user.country
  
  //dummy just to silence warning
  print(userName,emailAddress,phoneNumber,displayName,country)
}

//Example of setting the custom fields

private func snippet_3_blocking(){
  // Set some custom fields.
  let userFields = KiiUserFields()
  userFields.setObject(NSNumber(int: 20), forKey: "age")
  userFields.setObject("male", forKey: "gender")
  userFields.setObject(NSNumber(float: 170.5), forKey: "height")
  userFields.setObject(NSNumber(bool: true), forKey: "isMember")
  
  // Remove some custom fields
  userFields.removeFromServerForKey("weight")
  userFields.removeFromServerForKey("chest")
  
  
  let user = KiiUser.currentUser()
  var error : NSError?
  
  user.updateWithUserFieldsSynchronous(userFields, error: &error)
  
  if error != nil {
    // Error handling
    return
  }
}

private func snippet_3_non_blocking(){
  // Set some custom fields.
  let userFields = KiiUserFields()
  userFields.setObject(NSNumber(int: 20), forKey: "age")
  userFields.setObject("male", forKey: "gender")
  userFields.setObject(NSNumber(float: 170.5), forKey: "height")
  userFields.setObject(NSNumber(bool: true), forKey: "isMember")
  
  // Remove some custom fields
  userFields.removeFromServerForKey("weight")
  userFields.removeFromServerForKey("chest")
  
  
  let user = KiiUser.currentUser()
  user.updateWithUserFields(userFields) { (retUser, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}

//Example of getting the custom fields

private func snippet_4(){
  // Get the currently logged in user.
  let user = KiiUser.currentUser()
  let age = (user.getObjectForKey("age") as! NSNumber).integerValue
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
  
  var error : NSError?
  
  user.setObject(NSNumber(int: 30), forKey: "age")
  user.setObject(NSNumber(int: 0), forKey: "score")
  
  user.performRegistrationSynchronous(&error)
  
  if error != nil {
    // Error handling
    return
  }
}

private func snippet_4_non_blocking(){
  let username = "user_123456"
  let password = "123ABC"
  let user = KiiUser(username: username, andPassword: password)
  
  user.setObject(NSNumber(int: 30), forKey: "age")
  user.setObject(NSNumber(int: 0), forKey: "score")
  
  user.performRegistrationWithBlock { (retUser, error ) -> Void in
    if error != nil {
      // Error handling
      return
    }
  }
}
