//
//  quickstart_adding-kii-push-notification-to-your-application.swift
//  Snippet
//
//  Created by syahRiza on 12/11/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK: path quickstart/adding-kii-push-notification-to-your-application/

// Register Remote Notification

private func snippet_1(){
 func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
  
  // Kii initialization
  
  Kii.beginWithID("___APPID___", andKey: "___APPID___", andSite: .US)
  
  // Register APNS
  if #available(iOS 8, *) {
   let acceptAction = UIMutableUserNotificationAction()
   
   acceptAction.identifier = "ACCEPT_IDENTIFIER"
   acceptAction.title = "Accept"
   acceptAction.destructive = false
   
   let declineAction = UIMutableUserNotificationAction()
   
   declineAction.identifier = "DECLINE_IDENTIFIER"
   declineAction.title = "Decline"
   // will appear as red
   declineAction.destructive = true
   // tapping this actions will not launch the app but only trigger background task
   declineAction.activationMode = UIUserNotificationActivationMode.Background
   // this action will be executed without necessity of pass code authentication (if locked)
   declineAction.authenticationRequired = false;
   
   let inviteCategory = UIMutableUserNotificationCategory()
   
   inviteCategory.identifier = "MESSAGE_CATEGORY"
   inviteCategory.setActions([acceptAction,declineAction], forContext: UIUserNotificationActionContext.Default)
   inviteCategory.setActions([acceptAction,declineAction], forContext: UIUserNotificationActionContext.Minimal)
   let categories : Set<UIUserNotificationCategory>= [inviteCategory]
   
   // register notifications
   let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge,.Sound], categories: categories)
   application.registerUserNotificationSettings(notificationSettings)
   application.registerForRemoteNotifications()
  }
  else {
   application.registerForRemoteNotificationTypes([.Alert, .Badge,.Sound])
  }
  
  return true
 }
}

//Install User Devices
private func snippet_2_blocking(){
 func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
  
  do{
   try KiiPushInstallation.installSynchronousWithDeviceToken(deviceToken, andDevelopmentMode: true)
  }catch let error as NSError {
   print(error.description)
   //handling error
   return
  }
 }
}

private func snippet_2_non_blocking(){
 func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
  KiiPushInstallation.installWithDeviceToken(deviceToken, andDevelopmentMode: true) { (installation, error) -> Void in
   print(error.description)
   //handling error
   return
  }
 }
}
private func snippet_3(){
 func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
  print("Error : Fail to register to APNS : \(error)")
 }
}

//dummy to silence error
private let deviceToken = NSData()

//Uninstall User Devices
private func snippet_4_blocking(){
 do{
  try KiiPushInstallation.uninstallSynchronousWithDeviceToken(deviceToken)
 }catch let error as NSError {
  print(error.description)
  //handling error
  return
 }
}

private func snippet_4_non_blocking(){
 KiiPushInstallation.uninstallWithDeviceToken(deviceToken) { (installation, error) -> Void in
  print(error.description)
  //handling error
  return
 }
}
