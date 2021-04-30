//
//  Login.swift
//  SeniorProject
//
//  Created by Drew Malhotra on 4/20/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import SafariServices

struct Login: View {
    @State private var selectedLink: Int? = nil
      var body: some View {
        NavigationView {
        ZStack{
           WallpaperView()      //Add background
           VStack {
            TitleView()
                Button(action: {
                     UIApplication.shared.open(URL(string: "https://accounts.google.com/signin/v2/identifier?flowName=GlifWebSignIn&flowEntry=ServiceLogin")!)
                 }){
                     Text("Login via Google").modifier(ButtonModifiers())
                }
               Button(action: {
                    UIApplication.shared.open(URL(string: "https://twitter.com/login?lang=en-gb")!)
                }){
                    Text("Login via Twitter").modifier(ButtonModifiers())
         
                    }
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://www.facebook.com/login/web/")!)
                }){
                    Text("Login via Facebook").modifier(ButtonModifiers())
         
                    }
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://www.instagram.com/accounts/login/")!)
                }){
                    Text("Login via Instagram").modifier(ButtonModifiers())
         
                    }
                
                
           }}.edgesIgnoringSafeArea(.all)}}}

