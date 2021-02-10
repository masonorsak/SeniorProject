//
//  Furnace.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct Furnace: View {
    var body: some View {
      ZStack{
         Color("BackgroundColor")
         Text("Furnace")
            .font(.largeTitle)
      }.edgesIgnoringSafeArea(.all)
   }
}

struct Furnace_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        Furnace()
      }
    }
}
