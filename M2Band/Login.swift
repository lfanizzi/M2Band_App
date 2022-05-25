//
//  Login.swift
//  M2Band
//
//  Created by Team Greenies on 3/23/22.
//

import SwiftUI
import Foundation
import CoreBluetooth
import CoreGraphics
import UIKit


struct Login: View {
    @State public var username = ""
   // @State public var username2 = ""
    @State public var password = ""
    @State public var data1 = ""
    @Binding public var user_id : String
    @Binding public var login2 : Bool
    @Binding public var username2 : String
    @Binding public var careTaker : Bool
    @Binding public var launch2: Bool
    var body: some View {
        VStack{
            if(login2){
                Image("band").resizable().frame(width: 100, height: 100)
                Text("Please Enter Your Credentials").font(.title2).foregroundColor(.blue).bold().padding()
                TextField(" Username: \n", text: $username)
                TextField(" Password: \n", text: $password)
                
                //TextField("User ID Number\n", text: $user_id)
                if(data1.contains("user does not exist")){
                    Text("Login Failed, Please Try Again.").font(.title2).bold().foregroundColor(.red).padding()
                }
                if(data1.contains("success")){
                    Text("Login Success!").font(.title2).bold().foregroundColor(.blue).padding()
                }
                Button("Login"){
                    post_request()
                    if(data1.contains("success")){
                        Text("Login Success!").font(.title2).bold()
                        login2 = false
                    }
                }
                
                Toggle("Caretaker Mode", isOn: $careTaker)

                            if careTaker {
                                Text("Caretaker Mode on.")
                            }
            
            }//if statement
            else{
                
                    Image("profile").resizable().renderingMode(.original).frame(width:100, height: 100).padding()
                    Text("Profile").font(.title2).bold().padding()
                    
                ScrollView{
                    Text("Currently logged into M2Band").font(.title2).padding()
                    Text("Username: \(username2)").font(.title3).padding()
                    Text("User ID #:   \(user_id)").font(.title3).padding()
                    
                    Button("Logout"){
                        login2 = true
                    }
                }
    }//vstack
        }
}


func post_request(){
    // Create URL
    //print(username)
    username2 = username
    //print(username2)
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
            var components = data1.replacingOccurrences(of: "user_id", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
            //print(components.remove(at: 1))
            
            user_id = components.remove(at: 1)
            //print("user_id is \(user_id)")
            /*
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
             */
            
        }
        //print(user_id)
    }

    task.resume()
}

    func addVitalData(user_id : Int){
         
    }
    
    
    
}
/*
 
 */
