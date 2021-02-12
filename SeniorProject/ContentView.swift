//
//  ContentView.swift
//  Demo
//
//  Created by Mason Orsak on 2/7/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationView {
         ZStack{
            WallpaperView()      //Add background
            VStack {
               TitleView()       //UTD Title
               DividerView()     //Top of ScrollView
                  .offset(y: 7)
               ScrollView {      //Allow scrolling through buttons
                  VStack {       //Vertically align links
                     NavigationLink(destination: House()) {
                        Text("House")
                        .modifier(ButtonModifiers()) //Custom button modifiers
                     }//Add button to link to House page
                     
                     NavigationLink(destination: Dishwasher()) {
                        Text("Dishwasher")
                        .modifier(ButtonModifiers()) //Custom button modifiers
                     }//Add button to link to Dishwasher page
                     
                     NavigationLink(destination: Furnace()) {
                        Text("Furnace")
                        .modifier(ButtonModifiers()) //Custom button modifiers
                     }//Add button to link to Furnace page
                     
                     NavigationLink(destination: HomeOffice()) {
                        Text("Home Office")
                        .modifier(ButtonModifiers()) //Custom button modifiers
                     }//Add button to link to HomeOffice page
                     
                     NavigationLink(destination: Refrigerator()) {
                        Text(/*@START_MENU_TOKEN@*/"Refrigerator"/*@END_MENU_TOKEN@*/)
                        .modifier(ButtonModifiers()) //Custom button modifiers
                     }//Add button to link to Refrigerator page
                        
                     // ******* TEMP BUTTONS FOR TESTING, OKAY TO DELETE *******
                        NavigationLink(destination: Refrigerator()) {
                           Text("Sample")
                           .modifier(ButtonModifiers()) //Custom button modifiers
                        }//Add button to link to Refrigerator page
                        NavigationLink(destination: Refrigerator()) {
                           Text("Temp")
                           .modifier(ButtonModifiers()) //Custom button modifiers
                        }//Add button to link to Refrigerator page
                     // ******* TEMP BUTTONS FOR TESTING, OKAY TO DELETE *******
                     
                  } //End VStack
               } //End ScrollView
               DividerView()     //Bottom of ScrollView
                  .offset(y: -10)
               NavigationLink(destination: Settings()) {
                  Text("Settings")
                  .modifier(ButtonModifiers()) //Custom button modifiers
               }//Add button to link to Settings page
               
               SpacerView()      //Add space to the bottom of the screen
            }
         
         }.edgesIgnoringSafeArea(.all)    //Ignore the top and bottom of screen
      }
   }
}

//Homepage background
struct WallpaperView: View {
   var body: some View {
      Color("BackgroundColor")
      Image("BackgroundImage")
         .resizable()
         .scaledToFill()
         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
         .opacity(0.7)
         .blur(radius: 3)
   }
}

//Custom modifier for all the NavigationLinks as to not repeat code
struct ButtonModifiers: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.largeTitle)
         .accentColor(Color.white)
         .frame(width: 300.0, height: 45.0)
         .background(Color("ButtonOrange"))
         .cornerRadius(10)
         .padding(5)
   }
}

//Main UTD title on homepage
struct TitleView: View {
   var body: some View {
      Text("UTD")
         .font(.system(size: 100))
         .foregroundColor(Color.white)
         .fontWeight(.bold)
         .frame(width: 300, height: 255)
   }
}

//Invisible button to add spacing to bottom of the homepage view
struct SpacerView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("")
         .frame(width: 300.0, height: 30.0)
         .hidden()
      }
   }
}

//Dividers that seperate the top and bottom of the ScrollView
struct DividerView: View {
   var body: some View {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
         .fill(Color.white)
         .frame(width: 300, height: 3)
         .opacity(0.6)
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
