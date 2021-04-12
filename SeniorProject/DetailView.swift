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
   @State var deviceResults: [DeviceData] = []     // Array of DeviceData objects loaded from RDS
   @State var dayResults: [DayData] = []           // Array of DayData objects loaded from RDS
   //@State var anomalyResults: [DayData] = []       // Array of DayData objects loaded from RDS
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
            
            // Header displaying what device we are on
            Text(curDevice)
               .font(.system(size: 50))
               .fontWeight(.bold)
               .foregroundColor(.white)
               .padding(.top, 100)
            
            // map the floats to CG floats so we can graph them
            let avgEnergy = deviceResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.average)
               return tmp
            })
            
            // map the floats to CG floats so we can graph them
            let energyuse = dayResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.energyUse)
               return tmp
            })
            
//            let anomaly = anomalyResults.map({ (data) -> CGFloat in
//               let temp = CGFloat(0)
//               if let tmp = data.anomaly {
//                  let temp = CGFloat(tmp)
//               }
//               //print(tmp)
//               return temp
//            })
            
            DividerView()     // Rectangle marking visual top of ScrollView
               .offset(y: 7)
            
            displayGraph(monthData: avgEnergy, dayData: energyuse)
         }.onAppear {
            // Load device data from AppData.swift api call
            appData.loadDeviceData { (response) in
               self.deviceResults = response
            }
            
            // Load day device data from AppData.swift api call
            appData.loadDayData { (response) in
               self.dayResults = response
            }
            
//            // Load day device data from AppData.swift api call
//            appData.loadAnomalyData { (response) in
//               self.anomalyResults = response
//            }
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
   
   // function that builds our graph views
   @ViewBuilder func displayGraph(monthData: [CGFloat], dayData: [CGFloat]) -> some View{
      let screenWidth = UIScreen.main.bounds.size.width - 20
      ScrollView {      //Allow scrolling through graphs
         VStack {       //Vertically align graphs
            
            // Label the month graph
            Text("Month Energy Use")
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
            Text("24 Hour Energy Use")
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
            
//            LineGraph(dataPoints: anomaly.normalized)
//               .stroke(Color.green, lineWidth: 2)
//               .frame(width:400, height:300)
//               .border(Color.gray, width: 1)
//               .padding()
            
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
         return self.map { 0.95 * (($0 - min) / (max - min)) + 0.03}
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
