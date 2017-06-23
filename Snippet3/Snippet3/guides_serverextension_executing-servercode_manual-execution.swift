//
//  guides_serverextension_executing-servercode_manual-execution.swift
//  Snippet3
//
//  Created by syahRiza on 10/27/16.
//  Copyright © 2016 Kii. All rights reserved.
//

import Foundation

private func snippet_1_blocking(){
  let entry = Kii.serverCodeEntry("main")
  let argDict = ["username":"name_of_my_friend","password":"password_for_my_friend"]
  let argument = KiiServerCodeEntryArgument(dictionary:argDict)

  let result : KiiServerCodeExecResult
  do{
    result = try entry.executeSynchronous(argument)
  }catch(let error as NSError){
    // Error handling
    print(error,entry)
    return
  }
  // Parse the result.
  let returnedDict = result.returnedValue()
  let newUser = returnedDict?["returnedValue"];

  // Get the number of the exectued steps.
  let execSteps : Int = result.executedSteps()
  print(newUser ?? "",execSteps)
}

private func snippet_1_non_blocking(){
  let entry = Kii.serverCodeEntry("main")
  let argDict = ["username":"name_of_my_friend","password":"password_for_my_friend"]
  let argument = KiiServerCodeEntryArgument(dictionary:argDict)
  entry.execute(argument) { (retEntry : KiiServerCodeEntry, retArg : KiiServerCodeEntryArgument?, result : KiiServerCodeExecResult?, error : Error?) in
    if error != nil {
        // Handle the error.
        return
    }
    // Parse the result.
    let returnedDict = result?.returnedValue()
    let newUser = returnedDict?["returnedValue"];

    // Get the number of the exectued steps.
    let execSteps : Int = result!.executedSteps()
    print(newUser ?? "",execSteps)
  }
  
}

