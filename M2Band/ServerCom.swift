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
   
    //@State var v = "c"
    @State var data1 = ""
    //@State var indexing = 0
    //@State var temp = ""
    //@State var heart2 = 0
    @State var change_heart = ""
    @State var change_o2 = ""
    @State var change_temp = ""
    @State var change = false
    @Binding var heart : Int
    @Binding var O2 : Int
    @Binding var steps : Int
    @Binding var temp : Double
    @Binding var user_id : String
    var components : Array<String> = Array()
    var components2 : Array<String> = Array()
    var body: some View {
    
       // Text("Here is the Fetched Data: ").padding().font(.title)
        Button("Test GET Request"){
            get_request()
        }.padding()
        
        Button("Test POST Request"){
           //put_request()
            post_request()
        }.padding()
        Button("Change Data"){
            change = !change
        }
        if change{
            TextField("Heart Rate \n", text: $change_heart)
            TextField("Blood Oxygen \n", text: $change_o2)
            TextField("Temperature", text: $change_temp)
            Button("Submit Changes"){
                change_data()
            }
        }
        ScrollView{
            Text("Data is here: \(data1)")    //("Data is here: \(data1)")
        }
    }
    
    func get_request(){
        
        // Create URL
        let url = URL(string:"https://m2band.hopto.org/getSensorData?user_id=\(user_id)") //"https://m2band.hopto.org/getAllSensorData")
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
            
            var components = data1.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "data:", with: "").replacingOccurrences(of: "message:sensordataforallusers", with: "").components(separatedBy: ",")
                
               
           //Below is for extracting data to binding components
            for i in components{
                if i.contains("heart_rate"){
                   let i = i.replacingOccurrences(of: "heart_rate:", with: "")
                    heart = Int(i)!
                    break
                }
            }
            
            for i in components{
                if i.contains("blood_o2"){
                   let i = i.replacingOccurrences(of: "blood_o2:", with: "")
                    O2 = Int(i)!
                    break
                }
            }
            
            for i in components{
                if i.contains("temperature"){
                   let i = i.replacingOccurrences(of: "temperature:", with: "")
                    //print(i)
                    temp = Double(i)!
                    
                    break
                }
            }
            
           
            
            
                
            }
       
    task.resume()
        
    }
    
    func post_request(){
        // Create URL
        let url = URL(string: "https://m2band.hopto.org/login?username=user_\(user_id)&password=user_\(user_id)")
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
            
        }
    
        task.resume()
    }
    
    
    func change_data() {
        let url = URL(string:"https://m2band.hopto.org/addSensorData?user_id=\(user_id)&heart_rate=40&blood_o2=67&temperature=90")
       
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
            if data1.contains("sensor data added for"){
                heart = Int(change_heart)!
                O2 = Int(change_o2)!
                temp = Double(change_temp)!
            }
        change = false
       
            
    }
        task.resume()
        /*struct TaskEntry: Codable  {
            let id: Int
            let title: String
        }*/
    
    
}
    
}
