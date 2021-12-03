//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI
import CoreBluetooth
import CoreGraphics

var heart = 0
var O2 = 0
var steps = 0
//var Progress = 0
//@main

struct Main_Screen: View{
    @State public var Progress = 0
    @State public var BT = false
    var body: some View {
        NavigationView{
        VStack{
            HStack{
            Text("M2Band").fontWeight(.bold).padding().font(.largeTitle)
            }
            Text("Heart Rate (BPM) : \(heart)").fontWeight(.bold).padding().foregroundColor(.red)
            Text("Blood O2 Level: \(O2)").fontWeight(.bold).padding().foregroundColor(.blue)
            Text("Steps: \(steps)").fontWeight(.bold).padding().foregroundColor(.green)
            Text("Progress: \(Progress)").fontWeight(.bold).padding()
         
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
