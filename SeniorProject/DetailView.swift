//
//  DetailView.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/22/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct DetailView: View {
   @EnvironmentObject var appData: AppData         // Instance that holds our data
   @State var menuTitle: String = "Energy Use"     // Currently selected data to display, by default is energy use
   @State var deviceResults: [DeviceData] = []     // Array of DeviceData objects loaded from RDS
   @State var weatherResults: [WeatherData] = []   // Array of WeatjerData objects loaded from RDS
   var avgData: [Float] = []
   var selected: Int                               // What machine were examining (house, fridge, etc) as a int
   
   // Main view that organizes each element on the screen
   var body: some View {
      // Place items on z axis, aka on top of one another from back of phone to front
      ZStack{
         Color("BackgroundColor")   // Give the view a grey background color as defined in Assets
         
         // Align these items on y axis from top of screen to bottom
         VStack{
            let curDevice = getDeviceType(Device: selected)   // What device we are on (house, fridge) as a string
            // Measurements that we are making, will be held in picker view
            let measurements = ["Energy Use", "Temperature", "Humidity", "Pressure", "Wind Speed", "Dew Point"]
            
            // Header displaying what device we are on
            Text(curDevice)
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
            
            let avgEnergy = deviceResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.average)
               //print(tmp)
               return tmp
            })
            
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
            
            
            
            // If we have selected a device and not weather data then show that data
            if menuTitle == "Energy Use" {
               
               LineGraph(dataPoints: avgEnergy.normalized)
                  .stroke(Color.green, lineWidth: 2)
                  .aspectRatio(16/9, contentMode: .fit)
                  .border(Color.gray, width: 1)
                  .padding()
               
               List(deviceResults) { DeviceData in    // for every device data row make a list entry
                  VStack(alignment: .leading){        // align data entrys vertically
                     
                     // Depack the optional device data variables and if its not nil then display it
                     if let AvgID = DeviceData.avgid {
                        Text("Average ID: " + String(AvgID))
                     } else {
                        Text("Average ID: nil")
                     }
                     
                     if let deviceId = DeviceData.device_deviceid {
                        Text("DeviceID: " + String(deviceId))
                     } else {
                        Text("DeviceID: nil")
                     }

                     if let time = DeviceData.time {
                        Text("Time: " + String(time))
                     } else {
                        Text("Time: nil")
                     }
                     
                     if let average = DeviceData.average {
                        Text("Average Energy Use: " + String(average))
                     } else {
                        Text("Average Energy Use: nil")
                     }

                  } // end VStack
               } // end List
            } else {
               
               switch menuTitle {
               case "Temperature":
                  
                  LineGraph(dataPoints: avgTemp.normalized)
                     .stroke(Color.green, lineWidth: 2)
                     .aspectRatio(16/9, contentMode: .fit)
                     .border(Color.gray, width: 1)
                     .padding()
                  
               case "Humidity":
                  
                  LineGraph(dataPoints: avgHumidity.normalized)
                     .stroke(Color.green, lineWidth: 2)
                     .aspectRatio(16/9, contentMode: .fit)
                     .border(Color.gray, width: 1)
                     .padding()
                  
               case "Pressure":
                  
                  LineGraph(dataPoints: avgPressure.normalized)
                     .stroke(Color.green, lineWidth: 2)
                     .aspectRatio(16/9, contentMode: .fit)
                     .border(Color.gray, width: 1)
                     .padding()
                  
               case "Wind Speed":
                  
                  LineGraph(dataPoints: avgWindSpeed.normalized)
                     .stroke(Color.green, lineWidth: 2)
                     .aspectRatio(16/9, contentMode: .fit)
                     .border(Color.gray, width: 1)
                     .padding()
                  
               case "Dew Point":
                  
                  LineGraph(dataPoints: avgDewPoint.normalized)
                     .stroke(Color.green, lineWidth: 2)
                     .aspectRatio(16/9, contentMode: .fit)
                     .border(Color.gray, width: 1)
                     .padding()
                  
               default:
                  Text("Error: Picker View menu title contained invalid data")
               } // end switch
               
               List(weatherResults) { WeatherData in    // for every weather data row make a list entry
                  VStack(alignment: .leading){          // align data entrys vertically
                     
                     // Depack the optional weather data variables and if its not nil then display it
                     if let AvgID = WeatherData.avgid {
                        Text("Average ID: " + String(AvgID))
                     } else {
                        Text("Average ID: nil")
                     }

                     if let cityId = WeatherData.citydata_cityid {
                        Text("CityDataID: " + String(cityId))
                     } else {
                        Text("CityDataID: nil")
                     }

                     if let time = WeatherData.time {
                        Text("Time: " + String(time))
                     } else {
                        Text("Time: nil")
                     }
                     
                     // If we have selected this measurement then show its data after depacking optionals
                     switch menuTitle {
                     case "Temperature":
                        if let temp = WeatherData.tempavg {
                           Text("Temp: " + String(temp))
                        } else {
                           Text("Temp: nil")
                        }
                     case "Humidity":
                        if let hum = WeatherData.humidityavg {
                           Text("Humidity: " + String(hum))
                        } else {
                           Text("Humidity: nil")
                        }
                     case "Pressure":
                        if let pressure = WeatherData.pressureavg {
                           Text("Pressure: " + String(pressure))
                        } else {
                           Text("Pressure: nil")
                        }
                     case "Wind Speed":
                        if let wind = WeatherData.windspeedavg {
                           Text("Wind Speed: " + String(wind))
                        } else {
                           Text("Wind Speed: nil")
                        }
                     case "Dew Point":
                        if let dew = WeatherData.dewpointavg {
                           Text("Dew Point: " + String(dew))
                        } else {
                           Text("Dew Point: nil")
                        }
                     default:
                        Text("Error: Picker View menu title contained invalid data")
                     } // end switch

                  } // end VStack
               } // end List
            } // end weather data display
         }.onAppear {
            // Load device data from AppData.swift api call
            appData.loadDeviceData { (response) in
               self.deviceResults = response
            }
            // Load weather data from AppData.swift api call
            appData.loadWeatherData { (response) in
               self.weatherResults = response
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

struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}

extension Array where Element == CGFloat {
   var normalized: [CGFloat] {
      if let min = self.min(), let max = self.max() {
         return self.map { ($0 - min) / (max - min)}
      }
      return []
   }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
         DetailView(selected: 4).environmentObject(AppData(selected: 1))
      }
    }
}
