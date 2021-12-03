//
//  BT Connect Screen.swift
//  M2Band
//
//  Created by Luke Fanizzi on 11/30/21.
//

import SwiftUI
import CoreBluetooth

struct BT_Connect_Screen: View {
  
    var body: some View {
       // var i = 1
        var deviceList: [String] = ["iPhone", "iPad", "Mac"]
        VStack{
            Text("Bluetooth Devices: ").bold().foregroundColor(.blue).padding()
            HStack{
                List{
                    //for int i in 1...20 {
                   // }
                  //Text("\(i)")
                    Text("\(1)")
                    Text("\(2)")
                    Text("\(3)")
                    }.frame(width:100)
                
            List{
              //  for x in deviceList{
               // Text(deviceList[x])
                Text(deviceList[0])
                Text(deviceList[1])
                Text(deviceList[2])
                }
            }
        
            
            Button("Scan For Devices"){
              scan()
               
            }.padding()
            
            
            
        }
        
    }
}

public func scan(){
    let options: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey:
                                  NSNumber(value: false)]
    //centralManager = CBCentralManager(delegate: self, queue: .main)
}
struct BT_Connect_Screen_Previews: PreviewProvider {
    static var previews: some View {
        BT_Connect_Screen()
    }
}
