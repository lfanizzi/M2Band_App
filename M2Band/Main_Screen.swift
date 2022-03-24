//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI
import CoreBluetooth
import CoreGraphics
import UIKit



//var Progress = 0
//@main
//@State var progressValue: Float = 0.0

struct Main_Screen: View{
   // @State var data1 = ""
   // @State var indexing = 0
   // @State var tempvar = ""
   // @State var heart2 = 0
   // var components : Array<String> = Array()
    @State public var user_id = ""
    @State public var Progress = 0//87
    @State public var BT = false
    @State var heart  = 0//81
    @State public var O2 = 0//98
    @State public var steps = 0//2156
    @State public var temp = 0.0//98
    var body: some View {
        
        NavigationView{
    ZStack{
        //Color.gray
        VStack{
            
            Text("M2Band").fontWeight(.bold).font(.title)
            
            Image("band").resizable().frame(width: 75, height: 75)
            Spacer()
            HStack{
                Text("Heart Rate (BPM) :    \(heart)").fontWeight(.bold).padding().foregroundColor(.red)
                Image("heart_icon").resizable().frame(width: 25, height: 25)
            }
            HStack{
                Text("Blood O2 Level: \(O2)    ").fontWeight(.bold).padding().foregroundColor(.blue)
                Image("oxy_icon").resizable().frame(width: 50, height: 35)
            }
            HStack{
                Text("Steps: \(steps)                ").fontWeight(.bold).padding().foregroundColor(.green)
                Image("steps_icon").resizable().frame(width: 50, height: 35)
            }
            HStack{
                Text("   Temperature: \(Int(temp))     ").fontWeight(.bold).padding().foregroundColor(.orange)
                Image("thermo_icon").resizable().frame(width: 75, height: 75)
            }
            /*
            HStack{
                Text("Progress: \(Progress)              ").fontWeight(.bold).padding().foregroundColor(.yellow)
                Image("progress_icon").resizable().frame(width: 50, height: 50)
            }
             */
            Spacer()
           
            // NavigationLink( destination: BT_Connect_Screen()){
               // Text("Bluetooth").bold().padding()
            NavigationLink( destination: ServerCom(heart: $heart, O2:$O2, steps:$steps, temp:$temp, user_id: $user_id)){
                 Text("Fetch Data").bold().padding()
            }
            NavigationLink(destination: Login(user_id: $user_id)){
                Text("Login").bold().padding()
            }
            
            
          }
        }
    }
    }
}





struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
    }
}
/*
struct BT_Menu:View{
    var body: some View {
           Text("BT View")
       }
}
*/

