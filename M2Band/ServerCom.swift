//
//  ServerCom.swift
//  M2Band
//
//  Created by Luke Fanizzi on 3/21/22.
//

import Foundation
import SwiftUI
import UIKit

struct ServerCom: View {
   
    @State var v = "c"
    @State var data1 = ""
    @State var indexing = 0
    @State var temp = ""
    @State var heart2 = 0
    var components : Array<String> = Array()
    var body: some View {
    
       // Text("Here is the Fetched Data: ").padding().font(.title)
        Button("Test GET Request"){
            get_request()
        }.padding()
        
        Button("Test POST Request"){
           //put_request()
            post_request()
        }
        ScrollView{
            Text("Data is here: \(data1)")    //("Data is here: \(data1)")
        }
    }
    
    func get_request(){
        
        // Create URL
        let url = URL(string: "https://m2band.hopto.org/getAllSensorData")
       // let url = URL(string: "http://192.168.1.236:8080/")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
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
                //print("Response data string:\n \(dataString)")
                data1 = dataString
            
                var components = dataString.components(separatedBy: ":")
                print(components)
            }
                var x = 0
                for i in components{
                    if(i.elementsEqual("heart_rate")){
                        temp = components[x+1]
                        return
                    }
                        x+=1
                }
                
            
            let heart2 = Int(temp) ?? 0
            
              print(heart2)
    
                
            }
       
    task.resume()
        
    }
    
    func put_request(){
        // Create URL
        let url = URL(string: "https://m2band.hopto.org/")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "PUT"

        
       
        
    }
    
    
    func post_request() {
        let url = URL(string:"https://m2band.hopto.org/") //"https://m2band.hopto.org/login?username={user_1}&password={user_1}")
       // let url = URL(string: "http://192.168.1.236:8080/")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "POST"
  
    }
    
        struct TaskEntry: Codable  {
            let id: Int
            let title: String
        }
    
    
}
    

