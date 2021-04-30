//  Settings.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/10/21.
//  Copyright Â© 2021 Mason Orsak. All rights reserved.
//

import SwiftUI
import UIKit
import SafariServices
import MessageUI

struct Settings: View {
    @State private var selectedLink: Int? = nil
    var body: some View {
        NavigationView {
           ZStack{
              WallpaperView()      //Add background
              VStack {
                 TitleView()       //UTD Title
                 
                 NavigationLink(
                    destination: Login().environmentObject(AppData(selected: 0)),
                       tag: 3,
                       selection: $selectedLink)
                 {
                    Text("Login")
                    .modifier(ButtonModifiers())
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
                        let mailURL = URL(string: "message://dhruvmalhotra2020@gmail.com")!
                        if UIApplication.shared.canOpenURL(mailURL) {
                            UIApplication.shared.openURL(mailURL)
                        }
                    }){
                        Text("Send us an Email").modifier(ButtonModifiers())

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
                NavigationLink(
                   destination: LogOut().environmentObject(AppData(selected: 0)),
                      tag: 0,
                      selection: $selectedLink)
                {
                   Text("LogOut")
                   .modifier(ButtonModifiers())
                }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
            Settings()
            }
            NavigationView {
                Settings()
            }
        }
    }
}
