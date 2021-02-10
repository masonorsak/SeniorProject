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
            Color("BackgroundColor")
            Image("BackgroundImage")
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .opacity(0.7)
            .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            VStack {
               TitleView() //UTD Title
               Spacer()    //Put the buttons at the bottom of screen and title at the top
               
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
                  Text("HomeOffice")
                  .modifier(ButtonModifiers()) //Custom button modifiers
               }//Add button to link to HomeOffice page
               
               NavigationLink(destination: Refrigerator()) {
                  Text(/*@START_MENU_TOKEN@*/"Refrigerator"/*@END_MENU_TOKEN@*/)
                  .modifier(ButtonModifiers()) //Custom button modifiers
               }//Add button to link to Refrigerator page
               
               RoundedRectangle(cornerRadius: 25, style: .continuous)
                  .fill(Color.white)
                  .frame(width: 300, height: 3)
                  .opacity(0.6)
               
               NavigationLink(destination: Settings()) {
                  Text("Settings")
                  .modifier(ButtonModifiers()) //Custom button modifiers
               }//Add button to link to Settings page
               
               SpacerView()
            }
         }.edgesIgnoringSafeArea(.all)
      }
   }
}

struct ButtonModifiers: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.largeTitle)
         .accentColor(Color.white)
         .frame(width: 350.0, height: 60.0)
         .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
         .cornerRadius(10)
         .padding(10)
   }
}

struct TitleView: View {
   var body: some View {
      Text("UTD")
         .font(.system(size: 100))
         .foregroundColor(Color.white)
         .fontWeight(.bold)
         .offset(y: 100)
   }
}

struct SpacerView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("")
         .frame(width: 350.0, height: 40.0)
         .hidden()
      }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
