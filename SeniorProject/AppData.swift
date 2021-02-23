//
//  AppData.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/22/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

// Calculated stats that will be displayed below the graph
struct DataStats {
   var dataType: String
   var average: Float
   var low: Float
   var high: Float
}

// Different types of data for each machine, each with its own calculated DataStats
struct TypeOfData {
   var temperature: DataStats
   var humidity: DataStats
   var visibility: DataStats
   var pressure: DataStats
}

// The machine were currently looks at (ex house, dishwasher, frige, etc)
struct CurrentView {
   var typeOfData: TypeOfData
   var title: String
}

class AppData: ObservableObject {
   @Published var curView: [CurrentView]
   // Dummy data, will eventually be loaded from ML algorithm
   init() {
      curView = [
         CurrentView(typeOfData: TypeOfData(
            temperature: DataStats(dataType: "Temperature", average: 12.02, low: 2.03, high: 30.42),
            humidity: DataStats(dataType: "Humidity", average: 12.02, low: 2.03, high: 30.42),
            visibility: DataStats(dataType: "Visibility", average: 12.02, low: 2.03, high: 30.42),
            pressure: DataStats(dataType: "Pressure", average: 12.02, low: 2.03, high: 30.42)
         ), title: "House"),
         CurrentView(typeOfData: TypeOfData(
            temperature: DataStats(dataType: "Temperature", average: 12.02, low: 2.03, high: 30.42),
            humidity: DataStats(dataType: "Humidity", average: 12.02, low: 2.03, high: 30.42),
            visibility: DataStats(dataType: "Visibility", average: 12.02, low: 2.03, high: 30.42),
            pressure: DataStats(dataType: "Pressure", average: 12.02, low: 2.03, high: 30.42)
         ), title: "Dishwasher"),
         CurrentView(typeOfData: TypeOfData(
            temperature: DataStats(dataType: "Temperature", average: 12.02, low: 2.03, high: 30.42),
            humidity: DataStats(dataType: "Humidity", average: 12.02, low: 2.03, high: 30.42),
            visibility: DataStats(dataType: "Visibility", average: 12.02, low: 2.03, high: 30.42),
            pressure: DataStats(dataType: "Pressure", average: 12.02, low: 2.03, high: 30.42)
         ), title: "Furnace"),
         CurrentView(typeOfData: TypeOfData(
            temperature: DataStats(dataType: "Temperature", average: 12.02, low: 2.03, high: 30.42),
            humidity: DataStats(dataType: "Humidity", average: 12.02, low: 2.03, high: 30.42),
            visibility: DataStats(dataType: "Visibility", average: 12.02, low: 2.03, high: 30.42),
            pressure: DataStats(dataType: "Pressure", average: 12.02, low: 2.03, high: 30.42)
         ), title: "Home Office"),
         CurrentView(typeOfData: TypeOfData(
            temperature: DataStats(dataType: "Temperature", average: 12.02, low: 2.03, high: 30.42),
            humidity: DataStats(dataType: "Humidity", average: 12.02, low: 2.03, high: 30.42),
            visibility: DataStats(dataType: "Visibility", average: 12.02, low: 2.03, high: 30.42),
            pressure: DataStats(dataType: "Pressure", average: 12.02, low: 2.03, high: 30.42)
         ), title: "Refrigerator")
      ]
   }
}
