//
//  AppData.swift
//  SeniorProject
//
//  Created by Mason Orsak on 2/22/21.
//  Copyright © 2021 Mason Orsak. All rights reserved.
//

import SwiftUI

struct TaskEntry: Codable, Identifiable{
   let id = UUID()
   var DeviceID: Int?
   var DeviceType: Int?
   var HouseID: Int?
}


class AppData: ObservableObject {
   
   func loadData(completion: @escaping ([TaskEntry]) -> ()) {
      guard let url = URL(string: "https://xkvpwwf8kb.execute-api.us-east-2.amazonaws.com/prd") else {
         print("Your API end point is Invalid")
         return
      }
      //let request = URLRequest(url: url)

      URLSession.shared.dataTask(with: url) { (data, _, _) in
         let response = try! JSONDecoder().decode([TaskEntry].self, from: data!)
         
         DispatchQueue.main.async {
            completion(response)
         }
      }
      .resume()
   }
}
