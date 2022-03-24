//
//  Login.swift
//  M2Band
//
//  Created by Luke Fanizzi on 3/23/22.
//

import SwiftUI
import Foundation
import CoreBluetooth
import CoreGraphics
import UIKit


struct Login: View {
    @State public var username = ""
    @State public var password = ""
    @State public var data1 = ""
    @Binding public var user_id : String
    
    var body: some View {
        VStack{
            Text("Please Enter Your Credentials").font(.title).foregroundColor(.blue)
            TextField("Username: \n", text: $username)
            TextField("Password: \n", text: $password)
           // TextField("User ID Number\n", text: $user_id)
            
            Button("Login"){
                post_request()
            }
            ScrollView{
               Text( "\(data1)")
        }
    }

}


func post_request(){
    // Create URL
    let url = URL(string: "https://m2band.hopto.org/login?username=\(username)&password=\(password)")
    
    guard let requestUrl = url else { fatalError() }

    // Create URL Request
    var request = URLRequest(url: requestUrl)

    // Specify HTTP Method to use
    request.httpMethod = "GET"
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
        if data1.contains("user login success"){
            if(data1.contains("1")){
                user_id = "1"
            }
            else if (data1.contains("2")){
                user_id = "2"
            }
            else if(data1.contains("3")){
                user_id = "3"
            }
            else if(data1.contains("4")){
                user_id = "4"
            }
            else if(data1.contains("5")){
                user_id = "5"
            }
        }
        print(user_id)
    }

    task.resume()
}

    func addVitalData(user_id : Int){
         
    }
    
}
/*
 
 */
