//
//  Settings.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct Settings: View {
    var body: some View {
      ZStack{
         Color("BackgroundColor")
         Text("Settings")
            .font(.largeTitle)
      }.edgesIgnoringSafeArea(.all)
   }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        Settings()
      }
    }
}
