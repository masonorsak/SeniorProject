//
//  AppData.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/22/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

// Holds our hourly average device data for the past month
// Codable so it can holds JSON data from api call
// Identifiable so we can easily loop through data
struct DeviceData: Codable, Identifiable{
   let id = UUID()            // Needed for identifiable as looping id
   var avgid: Int            // Primary key of device data monthly average table
   var device_deviceid: Int  // Foreign key to device table
   var time: Int             // Unix time pulled from database
   var average: Float        // Average energy use over a one hour period
}

// Holds our hourly average weather data for the past month
// Codable so it can holds JSON data from api call
// Identifiable so we can easily loop through data
struct WeatherData: Codable, Identifiable{
   let id = UUID()            // Needed for identifiable as looping id
   var avgid: Int            // Primary key of weather data montly average table
   var citydata_cityid: Int  // Foreign key of city table
   var time: Int             // Unix time pulled from database
   var tempavg: Float        // Average temperature over an hour
   var humidityavg: Float    // Average humidity over an hour
   var pressureavg: Float    // Average pressure over an hour
   var windspeedavg: Float   // Average wind speed over an hour
   var dewpointavg: Float    // Average dew point over an hour
}

// Holds our 24 hour device data
// Codable so it can holds JSON data from api call
// Identifiable so we can easily loop through data
struct DayData: Codable, Identifiable{
   let id = UUID()            // Needed for identifiable as looping id
   var DeviceDataID: Int      // Primary key of device data
   var Device_DeviceID: Int   // Foreign key to device table
   var time: Int              // Unix time pulled from database
   var energyUse: Float       // energy over one minute
   var anomaly: Int?           // if this time slot has an anomaly
}

// Holds our weather data for the past day
// Codable so it can holds JSON data from api call
// Identifiable so we can easily loop through data
struct WeatherDayData: Codable, Identifiable{
   let id = UUID()            // Needed for identifiable as looping id
   var WeatherID: Int            // Primary key of weather data montly average table
   var CityData_CityID: Int  // Foreign key of city table
   var time: Int             // Unix time pulled from database
   var temp: Float        // Average temperature over an hour
   var humidity: Float    // Average humidity over an hour
   var pressure: Float    // Average pressure over an hour
   var windSpeed: Float   // Average wind speed over an hour
   var dewPoint: Float    // Average dew point over an hour
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
   
   // Make api call to the device we've selected and load data into our DeviceData structure
   func loadDayData(completion: @escaping ([DayData]) -> ()) {
      // Api endpoint url for device data
      guard let device_url = URL(string: "https://xkvpwwf8kb.execute-api.us-east-2.amazonaws.com/prd/24hour/" + String(select)) else {
         print("Your API end point is invalid for Device")
         return
      }
      
      // Make api call
      URLSession.shared.dataTask(with: device_url) { (data, _, _) in
         // Decode the JSON file into an array of DeviceData objects
         let response = try! JSONDecoder().decode([DayData].self, from: data!)
         
         // Asyncronously make api call so we can interact with the app while data is loading
         DispatchQueue.main.async {
            completion(response) // Return array of DeviceData objects
         }
      }
      .resume()
   }
   
//   // Make api call to the device we've selected and load data into our DeviceData structure
//   func loadAnomalyData(completion: @escaping ([DayData]) -> ()) {
//      // Api endpoint url for device data
//      guard let device_url = URL(string: "https://xkvpwwf8kb.execute-api.us-east-2.amazonaws.com/prd/anomaly/" + String(select)) else {
//         print("Your API end point is invalid for Device")
//         return
//      }
//
//      // Make api call
//      URLSession.shared.dataTask(with: device_url) { (data, _, _) in
//         // Decode the JSON file into an array of DeviceData objects
//         let response = try! JSONDecoder().decode([DayData].self, from: data!)
//
//         // Asyncronously make api call so we can interact with the app while data is loading
//         DispatchQueue.main.async {
//            completion(response) // Return array of DeviceData objects
//         }
//      }
//      .resume()
//   }
   
   // Make api call to the weather data table and load data into our WeatherData structure
   func loadWeatherDayData(completion: @escaping ([WeatherDayData]) -> ()) {
      // Api endpoint url for weather table data
      guard let weather_url = URL(string: "https://xkvpwwf8kb.execute-api.us-east-2.amazonaws.com/prd/24hourweather/1") else {
         print("Your API end point is invalid for Weather")
         return
      }
      
      // Make api call
      URLSession.shared.dataTask(with: weather_url) { (data, _, _) in
         // Decode the JSON file into an array of WeatherData objects
         let response = try! JSONDecoder().decode([WeatherDayData].self, from: data!)
         
         // Asyncronously make api call so we can interact with the app while data is loading
         DispatchQueue.main.async {
            completion(response) // Return array of WeatherData objects
         }
      }
      .resume()
   }
}
