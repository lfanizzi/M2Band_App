//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI
import CoreBluetooth
import CoreGraphics
import UIKit


var heart = 120
var O2 = 98
var steps = 2156
//var Progress = 0
//@main
//@State var progressValue: Float = 0.0

struct Main_Screen: View{
    @State public var Progress = 100
    @State public var BT = false
    var body: some View {
        NavigationView{
        VStack{
            
            Text("M2Band").fontWeight(.bold).font(.title)
        
            
            HStack{
            Text("Heart Rate (BPM) : \(heart)").fontWeight(.bold).padding().foregroundColor(.red)
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
            Text("Progress: \(Progress)             ").fontWeight(.bold).padding()
                Image("progress_icon").resizable().frame(width: 50, height: 50)
            }
           
           // Text("BT bool is: \(is_BT)" as String)
            NavigationLink(destination: BT_Connect_Screen()){
                Text("Bluetooth")
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
