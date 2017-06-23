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
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]?) -> Bool {

    // Kii initialization
    Kii.begin(withID: "___APPID___", andKey: "___APPID___", andSite: .US)

    // Register APNs
    // define notification actions (In case of categorized remote push notifications)
    let acceptAction = UIMutableUserNotificationAction()
    acceptAction.identifier = "ACCEPT_IDENTIFIER"
    acceptAction.title = "Accept"
    acceptAction.isDestructive = false

    let declineAction = UIMutableUserNotificationAction()
    declineAction.identifier = "DECLINE_IDENTIFIER"
    declineAction.title = "Decline"
    // will appear as red
    declineAction.isDestructive = true
    // tapping this actions will not launch the app but only trigger background task
    declineAction.activationMode = UIUserNotificationActivationMode.background
    // this action will be executed without necessity of pass code authentication (if locked)
    declineAction.isAuthenticationRequired = false;

    // Define Categories (In case of categorized remote push notifications)
    let inviteCategory = UIMutableUserNotificationCategory()
    inviteCategory.identifier = "MESSAGE_CATEGORY"
    inviteCategory.setActions([acceptAction,declineAction], for: UIUserNotificationActionContext.default)
    inviteCategory.setActions([acceptAction,declineAction], for: UIUserNotificationActionContext.minimal)
    let categories : Set<UIUserNotificationCategory> = [inviteCategory]

    // register notifications
    let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: categories)
    application.registerUserNotificationSettings(notificationSettings)
    application.registerForRemoteNotifications()

    return true
  }
}

//Install User Devices
private func snippet_2_blocking(){
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Install with APNs development mode : ON
    // make sure to change the value of developmentMode to false whenever make a release build (adhoc/ release to app store).
    do{
      try KiiPushInstallation.installSynchronous(withDeviceToken: deviceToken, andDevelopmentMode: true)
    }catch let error as NSError {
      print(error.description)
      // Error handling
      return
    }
  }
}

private func snippet_2_non_blocking(){
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Install with APNs development mode : ON
    // make sure to change the value of developmentMode to false whenever make a release build (adhoc/ release to app store).
    KiiPushInstallation.install(withDeviceToken: deviceToken, andDevelopmentMode: true) { (installation : KiiPushInstallation?, error : Error?) -> Void in

      print((error as! NSError).description)
      // Error handling
      return
    }
  }
}
private func snippet_3(){
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Error : Fail to register to APNs : \(error)")
  }
}

//dummy to silence error
private let deviceToken = Data()

//Uninstall User Devices
private func snippet_4_blocking(){
  do{
    try KiiPushInstallation.uninstallSynchronous(withDeviceToken: deviceToken)
  }catch let error as NSError {
    print(error.description)
    // Error handling
    return
  }
}

private func snippet_4_non_blocking(){
  KiiPushInstallation.uninstall(withDeviceToken: deviceToken) { (installation : KiiPushInstallation?, error : Error?) -> Void in
    print((error as! NSError).description)
    // Error handling
    return
  }
}
