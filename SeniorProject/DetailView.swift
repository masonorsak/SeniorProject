//
//  DetailView.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/22/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct DetailView: View {
   @EnvironmentObject var appData: AppData   // Instance that holds our data
   @State var menuTitle = "Temperature"      // Currently selected data to display
   var selected: Int                         // What machine were examining (house, fride, etc)
   
   // Main view that organizes each element on the screen
   var body: some View {
      ZStack{
         Color("BackgroundColor")
         VStack{
            Text("\(appData.curView[selected].title)")   // Page title
               .font(.system(size: 50))
               .fontWeight(.bold)
               .foregroundColor(.white)
               .frame(width: 300, height: 0)
            pickerMenu // Display data type list
         }
      }.edgesIgnoringSafeArea(.all)
   }
   
   // Select what data we want to view for this machine
   var pickerMenu: some View {
      VStack {
         // Array of different data for the current
         let allDataTypes = [
            appData.curView[selected].typeOfData.temperature.dataType,
            appData.curView[selected].typeOfData.humidity.dataType,
            appData.curView[selected].typeOfData.visibility.dataType,
            appData.curView[selected].typeOfData.pressure.dataType
         ] // array of different data types for this machine
         
         // Picker menu displaying the options
         Picker("Select Data", selection: $menuTitle) {
            ForEach(allDataTypes, id: \.self) {
               Text($0)
                  .fontWeight(.bold)
                  .foregroundColor(.white)
            }
         }
         // Temp text to display selection
         Text("You selected: \(menuTitle)")
            .fontWeight(.bold)
            .foregroundColor(.white)
      }
   }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
         DetailView(selected: 0).environmentObject(AppData())
      }
    }
}
