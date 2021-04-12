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
               .padding(.top, 50)
               .padding(.bottom, -70)
            
            // Allow user to select what data they want to see in a picker view
            Picker("Select Data", selection: $menuTitle) {
               ForEach(measurements, id: \.self) {
                  Text($0)
                     .fontWeight(.bold)
                     .foregroundColor(.white)
               }
            }
            
            DividerView()     // Rectangle marking visual top of ScrollView
               .offset(y: 7)
            
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
            
            // Display our graphs depending on what measurement we have selected
            switch menuTitle {
            case "Temperature":
               displayGraph(monthData: avgTemp.normalized, dayData: temp.normalized)
            case "Humidity":
               displayGraph(monthData: avgHumidity.normalized, dayData: humidity.normalized)
            case "Pressure":
               displayGraph(monthData: avgPressure.normalized, dayData: pressure.normalized)
            case "Wind Speed":
               displayGraph(monthData: avgWindSpeed.normalized, dayData: windSpeed.normalized)
            case "Dew Point":
               displayGraph(monthData: avgDewPoint.normalized, dayData: dewPoint.normalized)
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
   
   // function that builds our graph views
   @ViewBuilder func displayGraph(monthData: [CGFloat], dayData: [CGFloat]) -> some View{
      let screenWidth = UIScreen.main.bounds.size.width - 20
      ScrollView {      //Allow scrolling through graphs
         VStack {       //Vertically align graphs
            
            // Label the month graph
            Text("Month " + menuTitle)
               .font(.system(size: 20))
               .fontWeight(.bold)
               .foregroundColor(.white)
               .padding(.top, 20)
               .padding(.bottom, -10)
            
            // Plot the monthly data
            LineGraph(dataPoints: monthData.normalized)
               .stroke(Color.green, lineWidth: 2)
               .frame(width:screenWidth, height:300)
               .border(Color.gray, width: 1)
               .padding()
            
            calcAverage(avgData: monthData) // find average of monthly data
            
            // Label the day graph
            Text("24 Hour " + menuTitle)
               .font(.system(size: 20))
               .fontWeight(.bold)
               .foregroundColor(.white)
               .padding(.top, 20)
               .padding(.bottom, -10)
            
            // Plot the daily data
            LineGraph(dataPoints: dayData.normalized)
               .stroke(Color.green, lineWidth: 2)
               .frame(width:screenWidth, height:300)
               .border(Color.gray, width: 1)
               .padding()
            
            calcAverage(avgData: dayData) // find average of daily data
            
            // temporary padding from bottom of the view cause im bad at swift
            Text("")
               .padding(50)
         } // end vstack
      } // end scroll view
   } // end displayGraph
   
   // function that calulates average of our CGFloat arrays
   @ViewBuilder func calcAverage(avgData: [CGFloat]) -> some View{
      // Horizontally organize our min, max, and average
      HStack {
         // Use built in swift min function, unwrap value and display it
         if let monthMin = Float(avgData.min() ?? 0.0) {
            let format = String(format: "Min: %.4f", monthMin)
            Text(format)
               .foregroundColor(.white)
         }
         
         // Use built in swift max function, unwrap value and display it
         if let monthMax = Float(avgData.max() ?? 0.0) {
            let format = String(format: "Max: %.4f", monthMax)
            Text(format)
               .foregroundColor(.white)
         }
         
         // Swift has no built in average function, so build our own
         let sumArray = avgData.reduce(0, +)  // get sum of values
         let countArray = avgData.count       // get count of values
         // when view is loaded, before our data loads from api,
         // the array item count is 0, so we must check before
         // divinding by zero
         if countArray != 0 {
            // calculate the average and unwrap optional then display
            if let monthAvg = Float(sumArray) / Float(countArray) {
               let format = String(format: "Avg: %.4f", monthAvg)
               Text(format)
                  .foregroundColor(.white)
            }
         } else {
            Text("Avg: 0.0000")
               .foregroundColor(.white)
         }
      } // end HStack
   } // end calcAverage
} // end WeatherView

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
         WeatherView().environmentObject(AppData(selected: 1))
      }
    }
}
