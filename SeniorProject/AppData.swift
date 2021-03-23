//
//  AppData.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/22/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

// Holds our device data from RDS api call
// Codable so it can holds JSON data from api call
// Identifiable so we can easily loop through data
struct DeviceData: Codable, Identifiable{
   let id = UUID()            // Needed for identifiable as looping id
   var DeviceDataID: Int?     // Primary key of device data, auto incrementing
   var Device_DeviceID: Int?  // Primary key from device table, auto incrementing
   var time: Int?             // Unix time pulled from database
   var energyUse: Float?      // Energy use in kilowatts from database
   var anomaly: Int?          // Anomaly filled from ML, default nil, if not nil then there is an anomaly
}

// Holds our weather data from RDS api call
// Codable so it can holds JSON data from api call
// Identifiable so we can easily loop through data
struct WeatherData: Codable, Identifiable{
   let id = UUID()            // Needed for identifiable as looping id
   var WeatherID: Int?        // Primary key of weather data, auto incrementing
   var CityData_CityID: Int?  // Primary key of city table, auto incrementing
   var time: Int?             // Unix time pulled from database
   var temp: Float?
   var humidity: Float?
   var pressure: Float?
   var windSpeed: Float?
   var dewPoint: Float?
}

class AppData: ObservableObject {
   var select: Int   // Device_DeviceID value that we use for api call
   
   // when AppData is initialized assign what device we want to view
   init(selected: Int) {
      select = selected
   }
   
   // Make api call to the device we've selected and load data into our DeviceData structure
   func loadDeviceData(completion: @escaping ([DeviceData]) -> ()) {
      // Api endpoint url for device data
      guard let device_url = URL(string: "https://xkvpwwf8kb.execute-api.us-east-2.amazonaws.com/prd/device/" + String(select)) else {
         print("Your API end point is invalid for Device")
         return
      }
      
      // Make api call
      URLSession.shared.dataTask(with: device_url) { (data, _, _) in
         // Decode the JSON file into an array of DeviceData objects
         let response = try! JSONDecoder().decode([DeviceData].self, from: data!)
         
         // Asyncronously make api call so we can interact with the app while data is loading
         DispatchQueue.main.async {
            completion(response) // Return array of DeviceData objects
         }
      }
      .resume()
   }
   
   // Make api call to the weather data table and load data into our WeatherData structure
   func loadWeatherData(completion: @escaping ([WeatherData]) -> ()) {
      // Api endpoint url for weather table data
      guard let weather_url = URL(string: "https://xkvpwwf8kb.execute-api.us-east-2.amazonaws.com/prd/weather/1") else {
         print("Your API end point is invalid for Weather")
         return
      }
      
      // Make api call
      URLSession.shared.dataTask(with: weather_url) { (data, _, _) in
         // Decode the JSON file into an array of WeatherData objects
         let response = try! JSONDecoder().decode([WeatherData].self, from: data!)
         
         // Asyncronously make api call so we can interact with the app while data is loading
         DispatchQueue.main.async {
            completion(response) // Return array of WeatherData objects
         }
      }
      .resume()
   }
}
