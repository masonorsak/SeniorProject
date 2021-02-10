//
//  HomeOffice.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct HomeOffice: View {
    var body: some View {
      ZStack{
         Color("BackgroundColor")
         Text("HomeOffice")
            .font(.largeTitle)
      }.edgesIgnoringSafeArea(.all)
   }
}

struct HomeOffice_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        HomeOffice()
      }
    }
}
