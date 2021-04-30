//
//  LogOut.swift
//  SeniorProject
//
//  Created by Drew Malhotra on 4/20/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import SafariServices
struct LogOut: View {
    @State private var selectedLink: Int? = nil
    var body: some View {
        NavigationView {
        ZStack{
           WallpaperView()      //Add background
           VStack {
            TitleView()
                 Text("Logout Successful!").modifier(ButtonModifiers())
            }}.edgesIgnoringSafeArea(.all)}}}
