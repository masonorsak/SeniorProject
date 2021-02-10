//
//  House.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct House: View {
    var body: some View {
      ZStack{
         Color("BackgroundColor")
         Text("House")
            .font(.largeTitle)
      }.edgesIgnoringSafeArea(.all)
   }
}

struct House_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        House()
      }
    }
}
