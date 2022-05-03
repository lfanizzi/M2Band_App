//
//  history.swift
//  M2Band
//
//  Created by Luke Fanizzi on 4/3/22.
//

import Foundation
import CoreBluetooth
import CoreGraphics
import UIKit
import Foundation
import SwiftUI

struct history: View{
    @State public var data1 = ""
    @Binding public var user_id : String
    var body : some View{
        Image("history").resizable().renderingMode(.original).frame(width:100, height: 100).padding()
        Text("History").font(.title2).bold().padding()
        Button("Get History"){
            get_request()
        }
    ScrollView{
        Text("\(data1)")
    }
    }


func get_request(){
    // Create URL
    let url = URL(string:"https://m2band.hopto.org/get/oximeter/user_id/\(user_id)")
   // let url = URL(string: "http://192.168.1.236:8080/")
    guard let requestUrl = url else { fatalError() }
    // Create URL Request
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    // Send HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check if Error took place
        if let error = error {
            print("Error took place \(error)")
            return
        }
        
        // Read HTTP Response Status code
        if let response = response as? HTTPURLResponse {
            print("Response HTTP Status code: \(response.statusCode)")
        }
        
        // Convert HTTP Response Data to a simple String
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            data1 = dataString
        }
    }
    task.resume()
}
}
