//
//  Dishwasher.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct Dishwasher: View {
    var body: some View {
      ZStack{
         Color("BackgroundColor")
         Text("Dishwasher")
            .font(.largeTitle)
      }.edgesIgnoringSafeArea(.all)
   }
}

struct Dishwasher_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        Dishwasher()
      }
    }
}
