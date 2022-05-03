//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI
import CoreBluetooth
import CoreGraphics
import UIKit

struct Main_Screen: View{
    @State public var user_id = ""
    @State public var username2 = ""
    @State public var Progress = 0//87
    @State public var BT = false
    @State var heart  = 0//95//81
    @State public var O2 = 0//95 //98
    @State public var steps = 0//2156
    @State public var temp = 0.0//102.0//98
    @State public var login2 = true
    @State var data1 = ""
    @State public var careTaker = false
    @State public var dat = ""
    var body: some View {
        if (login2){
            Login(user_id: $user_id, login2: $login2, username2: $username2, careTaker: $careTaker)
        }
       
        
        else if(careTaker){
            NavigationView{
        ZStack{
            Color(.gray).opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack(spacing: 1){
                
                Text("M2Band").fontWeight(.bold).font(.title).frame(width: 120, height: 80, alignment: .topLeading)
                
                Image("band").resizable().frame(width: 75, height: 75).padding()

                HStack{
                    Text("  Heart Rate (BPM) :    ").fontWeight(.bold).frame(alignment: .leading)
                    Text("\(heart)").fontWeight(.bold).padding().padding().frame(alignment: .center)
                    Spacer()
                     
                    if(heart < 60 || heart > 100){
                        Image("Emergency").resizable().frame(width: 50, height: 35).padding()
                        }
                    
                    else if(heart < 70 || heart > 90 ){
                        Image("Warning_Symbol").resizable().frame(width: 50, height: 35).padding()
                    }
                    
                }
                HStack{
                    Text("  Blood O2 Level:          ").fontWeight(.bold).frame(alignment: .leading)
                    Text("\(O2)").fontWeight(.bold).padding().padding().frame(alignment: .center)
                    Spacer()
                    if(O2 <= 96 && O2 > 93){
                        Image("Warning_Symbol").resizable().frame(width: 50, height: 35).padding()
                    }
                    else if(O2 < 93){
                        Image("Emergency").resizable().frame(width: 50, height: 35).padding()
                    }
                    
                }
                HStack{
                    Text("  Steps:                             ").fontWeight(.bold).frame(alignment: .leading)
                    Text("\(steps)").fontWeight(.bold).padding().padding().frame(alignment: .center)
                    Spacer()
                    //Image("steps_icon").resizable().frame(width: 50, height: 35).padding()
                }
                HStack{
                    Text("  Temperature:                 ").fontWeight(.bold).frame(alignment: .leading)
                    Text("\(Int(temp))").fontWeight(.bold).padding().frame(alignment: .center)
                    Spacer()
                    if(temp > 100.4 && temp < 103){
                        Image("Warning_Symbol").resizable().frame(width: 50, height: 35).padding()
                    }
                    else if(temp > 103){
                        Image("Emergency").resizable().frame(width: 50, height: 35).padding()
                    }
                   
                }
                
                HStack{
                    Text("  Progress:                      ").fontWeight(.bold).frame(alignment: .leading)
                    Text("\(Progress)").fontWeight(.bold).padding().padding().frame(alignment: .center)
                    Spacer()
                    //Image("progress_icon").resizable().frame(width: 50, height: 50).padding()
                }
                
                     HStack {
                         NavigationLink(destination: settings(user_id : $user_id)) {
                             Image("gear2").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                              }.buttonStyle(ThemeAnimationStyle()).padding()
                         NavigationLink(destination: Login(user_id:$user_id, login2: $login2, username2: $username2, careTaker: $careTaker)) {
                            Image("profile").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                            }.buttonStyle(ThemeAnimationStyle()).padding()
                         NavigationLink(destination: history(user_id:$user_id)) {
                             Image("history").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                         }.buttonStyle(ThemeAnimationStyle()).padding()
                         
                     }.frame(height: 100)//.transition(.move(edge: .top)).animation(.easeIn(duration: 5))
              }//vstack
            }//zstack
            }//nav view
            
            
            
            
            
        }
        else{
        NavigationView{
    ZStack{
       
        Color(.gray).opacity(0.2).edgesIgnoringSafeArea(.all)
        VStack(spacing: 1){
            
            Text("M2Band").fontWeight(.bold).font(.title).frame(width: 120, height: 80, alignment: .topLeading)
            
            Image("band").resizable().frame(width: 75, height: 75).padding()
            //Spacer()
           // List{
            HStack{
                Text("  Heart Rate (BPM) :    ").fontWeight(.bold).foregroundColor(.red).frame(alignment: .leading)
                Text("\(heart)").fontWeight(.bold).padding().foregroundColor(.red).padding().frame(alignment: .center)
                Spacer()
                Image("heart_icon").resizable().frame(width: 25, height: 25).padding()
            }
            HStack{
                Text("  Blood O2 Level:          ").fontWeight(.bold).foregroundColor(.blue).frame(alignment: .leading)
                Text("\(O2)").fontWeight(.bold).padding().foregroundColor(.blue).padding().frame(alignment: .center)
                Spacer()
                Image("oxy_icon").resizable().frame(width: 50, height: 35).padding()
            }
            HStack{
                Text("  Steps:                             ").fontWeight(.bold).foregroundColor(.green).frame(alignment: .leading)
                Text("\(steps)").fontWeight(.bold).padding().foregroundColor(.green).padding().frame(alignment: .center)
                Spacer()
                Image("steps_icon").resizable().frame(width: 50, height: 35).padding()
            }
            HStack{
                Text("  Temperature:              ").fontWeight(.bold).foregroundColor(.orange).frame(alignment: .leading)
                Text("\(Int(temp))").fontWeight(.bold).padding().foregroundColor(.orange).padding().frame(alignment: .center)
                Spacer()
                Image("thermo_icon").resizable().frame(width: 75, height: 75)
            }
            
            HStack{
                Text("  Progress:                      ").fontWeight(.bold).foregroundColor(.yellow).frame(alignment: .leading)
                Text("\(Progress)").fontWeight(.bold).padding().foregroundColor(.yellow).padding().frame(alignment: .center)
                Spacer()
                Image("progress_icon").resizable().frame(width: 50, height: 50).padding()
            }
            
                 HStack {
                     NavigationLink(destination: settings(user_id : $user_id)) {
                         Image("gear2").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                          }.buttonStyle(ThemeAnimationStyle()).padding()
                     NavigationLink(destination: Login(user_id:$user_id, login2: $login2, username2: $username2, careTaker: $careTaker)) {
                        Image("profile").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                        }.buttonStyle(ThemeAnimationStyle()).padding()
                     NavigationLink(destination: history(user_id:$user_id)) {
                         Image("history").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                     }.buttonStyle(ThemeAnimationStyle()).padding()
                     
                    // Button("Refresh"){
                        // updateValues()
                    // }.foregroundColor(.black)
                     Button("Refresh"){
                         updateValues()
                     }
                     //NavigationLink( destination: ServerCom(heart: $heart, O2:$O2, steps:$steps, temp:$temp, user_id: $user_id)){
                        // Text("$").bold().padding().foregroundColor(.black)
                    // }.buttonStyle(ThemeAnimationStyle()).padding()
                 }.frame(height: 100)//.transition(.move(edge: .top)).animation(.easeIn(duration: 5))
        }//vstack
        }//ZStack
        }//navView.
        }
        
    }
    

struct ThemeAnimationStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title2)
            .foregroundColor(Color.white)
            .frame(height: 50, alignment: .center)
            .background(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            .cornerRadius(8)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) //<- change scale value as per need. scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}




    public func updateValues(){
        //Timing component for pulling relavant data
        let date = Date()
        let dateFormatter = DateFormatter()
         
        dateFormatter.dateFormat = "yyyy-MM-dd"
         
        let just_date = dateFormatter.string(from: date)
        
        //let day = (Calendar.current.component(.day, from: date))
        var hours   = (Calendar.current.component(.hour, from: date))
        var minutes = (Calendar.current.component(.minute, from: date))
        var seconds = (Calendar.current.component(.second, from: date))
        seconds -= 5
        //minutes -= 1
        //dat = just_date.replacingOccurrences(of: ".", with: "-")
            
        
        
        let date2 = dat.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: " ", with: "")
       
        
        
        //let url = URL(string: "https://m2band.hopto.org/get/oximeter/user_id/1?filter=entry_time%3E%22\"2022-04-05%2015:29:41.223%22") //this works
        //let url = URL(string: "https://m2band.hopto.org/get/oximeter/user_id/\(user_id)?filter=(entry_time%20%3E%20%222022-05-03%2013:29:05%22)")//works
        let url = URL(string: "https://m2band.hopto.org/get/oximeter/user_id/\(user_id)?filter=(entry_time%20%3E%20%22\(just_date)%20\(hours):\(minutes):\(seconds)%22)")//works
        //print(url)
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
                
               
           //Below is for taking data
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

}


/*NavigationLink( destination: ServerCom(heart: $heart, O2:$O2, steps:$steps, temp:$temp, user_id: $user_id)){
     Text("Fetch Data").bold().padding()
}*/

    //NavigationLink(destination: Login(user_id: //$user_id, login2: $login2)){
    //Text("Logout").bold().padding()
    
// }
//  } //end of list
