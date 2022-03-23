//
//  BT Connect Screen.swift
//  M2Band
//
//  Created by Luke Fanizzi on 11/30/21.
//

import SwiftUI
import CoreBluetooth
import UIKit
import os
import OSLog

var centralManager: CBCentralManager!

var discoveredPeripheral: CBPeripheral?
var transferCharacteristic: CBCharacteristic?
var data = Data()

struct BT_Connect_Screen: View {
  
    var body: some View {
       // var i = 1
        var deviceList: [String] = ["iPhone", "iPad", "Mac"]
        VStack{
            Image("blue_icon").resizable().frame(width: 50, height: 50)
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

public func connect_server(){
    
}
public func scan(){
    
    
}
