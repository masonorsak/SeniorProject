//
//  WeatherView.swift
//  SeniorProject
//
//  Created by Mason Orsak on 4/11/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
   @EnvironmentObject var appData: AppData               // Instance that holds our data
   @State var menuTitle: String = "Temperature"          // Currently selected data to display, by default is energy use
   @State var weatherResults: [WeatherData] = []         // Array of WeatherData objects loaded from RDS
   @State var weatherDayResults: [WeatherDayData] = []   // Array of WeatherDayData objects loaded from RDS
   var avgData: [Float] = []
   
   // Main view that organizes each element on the screen
   var body: some View {
      // Place items on z axis, aka on top of one another from back of phone to front
      ZStack{
         Color("BackgroundColor")   // Give the view a grey background color as defined in Assets
         
         // Align these items on y axis from top of screen to bottom
         VStack{
            // Measurements that we are making, will be held in picker view
            let measurements = ["Temperature", "Humidity", "Pressure", "Wind Speed", "Dew Point"]
            
            // Header displaying what device we are on
            Text("Weather")
               .font(.system(size: 50))
               .fontWeight(.bold)
               .foregroundColor(.white)
               .padding(.top, 100)
               .padding(.bottom, -50)
            
            // Allow user to select what data they want to see in a picker view
            Picker("Select Data", selection: $menuTitle) {
               ForEach(measurements, id: \.self) {
                  Text($0)
                     .fontWeight(.bold)
                     .foregroundColor(.white)
               }
            }
            
            // Display what the user has selected from picker view for debugging
            Text("You selected: \(menuTitle)")
               .fontWeight(.bold)
               .foregroundColor(.white)
            
            // convert monthly data floats to CGFloats
            let avgTemp = weatherResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.tempavg)
               //print(tmp)
               return tmp
            })
            
            let avgHumidity = weatherResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.humidityavg)
               //print(tmp)
               return tmp
            })
            
            let avgPressure = weatherResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.pressureavg)
               //print(tmp)
               return tmp
            })
            
            let avgWindSpeed = weatherResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.windspeedavg)
               //print(tmp)
               return tmp
            })
            
            let avgDewPoint = weatherResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.dewpointavg)
               //print(tmp)
               return tmp
            })
            
            // convert daily data floats to CGFloats
            let temp = weatherDayResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.temp)
               //print(tmp)
               return tmp
            })
            
            let humidity = weatherDayResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.humidity)
               //print(tmp)
               return tmp
            })
            
            let pressure = weatherDayResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.pressure)
               //print(tmp)
               return tmp
            })
            
            let windSpeed = weatherDayResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.windSpeed)
               //print(tmp)
               return tmp
            })
            
            let dewPoint = weatherDayResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.dewPoint)
               //print(tmp)
               return tmp
            })
               
            switch menuTitle {
            case "Temperature":
               
               ScrollView {      //Allow scrolling through graphs
                  VStack {       //Vertically align graphs
                     
                     LineGraph(dataPoints: avgTemp.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                     
                     LineGraph(dataPoints: temp.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                  }
               }
               
            case "Humidity":
               
               ScrollView {      //Allow scrolling through graphs
                  VStack {       //Vertically align graphs
                     LineGraph(dataPoints: avgHumidity.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                     
                     LineGraph(dataPoints: humidity.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                  }
               }
               
            case "Pressure":
               
               ScrollView {      //Allow scrolling through graphs
                  VStack {       //Vertically align graphs
                     LineGraph(dataPoints: avgPressure.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                     
                     LineGraph(dataPoints: pressure.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                  }
               }
               
            case "Wind Speed":
               
               ScrollView {      //Allow scrolling through graphs
                  VStack {       //Vertically align graphs
                     LineGraph(dataPoints: avgWindSpeed.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                     
                     LineGraph(dataPoints: windSpeed.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                  }
               }
               
            case "Dew Point":
               
               ScrollView {      //Allow scrolling through graphs
                  VStack {       //Vertically align graphs
                     LineGraph(dataPoints: avgDewPoint.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                     
                     LineGraph(dataPoints: dewPoint.normalized)
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width:400, height:300)
                        .border(Color.gray, width: 1)
                        .padding()
                  }
               }
               
            default:
               Text("Error: Picker View menu title contained invalid data")
            } // end switch
         }.onAppear {
            // Load monthly weather data from AppData.swift api call
            appData.loadWeatherData { (response) in
               self.weatherResults = response
            }
            // Load daily weather data from AppData.swift api call
            appData.loadWeatherDayData { (response) in
               self.weatherDayResults = response
            }
         }
      }.edgesIgnoringSafeArea(.all)
   }
   
   // Take device type from database and return a string for what that
   // device is, see chart in project details doc for encoding scheme
   func getDeviceType(Device: Int) -> String {
      switch Device {
      case 1:
         return "Time"
      case 2:
         return "Use [kW]"
      case 3:
         return "Gen [kW]"
      case 4:
         return "House"
      case 5:
         return "Dishwasher"
      case 6:
         return "Furnace"
      case 7:
         return "Home Office"
      case 8:
         return "Refrigerator"
      case 9:
         return "Wine Cellar"
      case 10:
         return "Garage Door"
      case 11:
         return "Kitchen"
      case 12:
         return "Barn"
      case 13:
         return "Well"
      case 14:
         return "Microwave"
      case 15:
         return "Living Room"
      default:
         return "Type Unknown"
      }
   }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
         WeatherView()
      }
    }
}
