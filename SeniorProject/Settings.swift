//  Settings.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright Â© 2021 Mason Orsak. All rights reserved.
//

import SwiftUI
import UIKit
import SafariServices

struct Settings: View {
    @State private var selectedLink: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
               WallpaperView()

                VStack {
                    Button(action: {
                           UIApplication.shared.open(URL(string:
                    "http://www.apple.com/")!)
                    }){
                        Text("Log In").modifier(ButtonModifiers())

                    }
                    Button(action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }){
                        Text("Phone Settings").modifier(ButtonModifiers())
                    }
                    Button(action: {
                        UIApplication.shared.open(URL(string:"App-Prefs:root=NOTIFICATIONS_ID")!, options: [:], completionHandler: nil)
                    }){
                        Text("Adjust Notifications").modifier(ButtonModifiers())
                    }
                    Button(action: {
                           UIApplication.shared.open(URL(string:
                    "https://www.twitter.com")!)
                    }){
                        Text("Share on Twitter").modifier(ButtonModifiers())

                    }
                    Button(action: {
                           UIApplication.shared.open(URL(string:
                    "https://www.facebook.com")!)
                    }){
                        Text("Share on Facebook").modifier(ButtonModifiers())

                    }
                    Button(action: {
                           UIApplication.shared.open(URL(string:
                    "https://www.instagram.com")!)
                    }){
                        Text("Share on Instagram").modifier(ButtonModifiers())

                    }
                    Button(action: {
                        UIApplication.shared.open(URL(string: "https://www.apple.com/app-store/")!)
                    }){
                        Text("Rate our App").modifier(ButtonModifiers())

                    }
                    Button(action: {
                           UIApplication.shared.open(URL(string:
                    "http://www.apple.com/")!)
                    }){
                        Text("Log Out").modifier(ButtonModifiers())

                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        Settings()
      }
    }
}
