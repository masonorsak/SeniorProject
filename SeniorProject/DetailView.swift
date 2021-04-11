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
            
            // Display what the user has selected from picker view for debugging
            Text("Energy Use")
               .fontWeight(.bold)
               .foregroundColor(.white)
            
            let avgEnergy = deviceResults.map({ (data) -> CGFloat in
               let tmp = CGFloat(data.average)
               //print(tmp)
               return tmp
            })
               
            LineGraph(dataPoints: avgEnergy.normalized)
               .stroke(Color.green, lineWidth: 2)
               .frame(width:400, height:300)
               .border(Color.gray, width: 1)
               .padding()
            
            List(deviceResults) { DeviceData in    // for every device data row make a list entry
               VStack(alignment: .leading){        // align data entrys vertically
                  
                  // Depack the optional device data variables and if its not nil then display it
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
         }.onAppear {
            // Load device data from AppData.swift api call
            appData.loadDeviceData { (response) in
               self.deviceResults = response
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
