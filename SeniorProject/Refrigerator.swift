//
//  Refrigerator.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/9/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct Refrigerator: View {
    var body: some View {
      ZStack{
         Color("BackgroundColor")
         Text("Refrigerator")
            .font(.largeTitle)
      }.edgesIgnoringSafeArea(.all)
   }
}

struct Refrigerator_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        Refrigerator()
      }
    }
}
