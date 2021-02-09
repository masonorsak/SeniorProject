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
      ZStack{
         Color("BackgroundColor")
         Image("BackgroundImage")
         .resizable()
         .scaledToFill()
         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
         .opacity(0.7)
         .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
         VStack {
            TitleView()
            Spacer()
            RefrigeratorView()
            OvenView()
            ACView()
            HeatingView()
            ComputerView()
            RoundedRectangle(cornerRadius: 25, style: .continuous)
               .fill(Color.white)
               .frame(width: 300, height: 3)
               .offset(y: -50)
               .opacity(0.6)
            SettingsView()
         }
      }.edgesIgnoringSafeArea(.all)
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
         .offset(y: -50)
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

struct RefrigeratorView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text(/*@START_MENU_TOKEN@*/"Refrigerator"/*@END_MENU_TOKEN@*/)
         .modifier(ButtonModifiers())
      }
   }
}

struct OvenView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("Oven")
         .modifier(ButtonModifiers())
      }
   }
}

struct ACView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("Air Conditioner")
         .modifier(ButtonModifiers())
      }
   }
}

struct HeatingView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("Central Heating")
         .modifier(ButtonModifiers())
      }
   }
}

struct ComputerView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("Computer")
         .modifier(ButtonModifiers())
      }
   }
}

struct SettingsView: View {
   var body: some View {
      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
         Text("Settings")
         .modifier(ButtonModifiers())
      }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
