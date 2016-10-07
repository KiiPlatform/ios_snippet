//
//  ab-testing_integrating_ab_test.swift
//  Snippet
//
//  Created by syahRiza on 12/18/15.
//  Copyright © 2015 Kii. All rights reserved.
//

import Foundation

//MARK : path guides/ab-testing/integrating_ab_test/
//Retrieving an Experiment
private func snippet_1(){
  // Get experiment synchronously
  let experiment : KiiExperiment
  
  do{
    experiment = try KiiExperiment.getSynchronous("7a9d430f-fef6-424d-a521-7e07318650fa")
  }catch let error as NSError {
    print(error)
    // handle error
    return
  }
  
  print(experiment)
}
private let experiment : KiiExperiment = KiiExperiment()

//Apply a Variation
private func snippet_2(){
  let variation : KiiVariation
  do{
    variation = try experiment.appliedVariation()
    
  }catch{
    // Failed to apply a variation
    // (Check error.code for the failure reason)
    // In this example, 'A' would be applied when failing to apply a variation randomly.
    variation = experiment.variation(byName: "A")!
  }
  
  let variableSet = variation.variableDictionary!
  
  // Get the details for Variation "A"
  let buttonColor = variableSet["buttonColor"] as! String
  let buttonLabel = variableSet["buttonLabel"] as! String
  // Apply the color and label to the button.
  
  print(buttonColor,buttonLabel)
}
//Sampler variation without user login
private func snippet_3(){
  // Assume this is the variable set for Variation 'A';
  var buttonColor = "green";
  var buttonLabel = "Get Started Now!";
  
  //Define sampler based on execution timestamp.
  let randomSampler =  KiiRandomVariationSampler()
  
  let fallback = experiment.variation(byName: "A")
  let variation = experiment.appliedVariation(with: randomSampler, fallback: fallback)!
  
  let variableSet = variation.variableDictionary!
  
  // Get the details for Variation "A"
  buttonColor = variableSet["buttonColor"] as! String
  buttonLabel = variableSet["buttonLabel"] as! String
  // Apply the color and label to the button.
  
  print(buttonColor,buttonLabel)
}
let variation = KiiVariation()
//Sending Events
private func snippet_4(){
  // The button is displayed and "eventViewed" event triggered.
  let viewEvent = variation.eventDictionaryForConversion(withName: "eventViewed")
  
  // The button is clicked and "eventClicked" event triggered.
  let clickEvent = variation.eventDictionaryForConversion(withName: "eventClicked")
  
  // In this example we ignore the user operation context.
  // In a real application you should send it to the handler of the controller class.
  KiiAnalytics.trackEvent(experiment.experimentID, withExtras: viewEvent)
  KiiAnalytics.trackEvent(experiment.experimentID, withExtras: clickEvent)
}
