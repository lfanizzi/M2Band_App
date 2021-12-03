//
//  M2BandApp.swift
//  M2Band
//
//  Created by Luke Fanizzi on 10/19/21.
//

import SwiftUI
import CoreBluetooth
import Foundation
public var is_BT = false
var i = 0
@main

struct M2BandApp: App {
    
    var body: some Scene {
        
        WindowGroup{
           
           
        
               Main_Screen()
            
            
           // switchViews(is_BT: changeBT(BT: get_is_BT()))
            

        }
        }
    
    
   
      
    
   
    
}
public func get_is_BT() -> Bool{
    return is_BT
}

@ViewBuilder public func switchViews(is_BT : Bool ) -> some View{
    
    if(!is_BT){
       Main_Screen()
    }
    else{
        BT_Connect_Screen()
    }
}
public func showBT(butt : Bool) -> Void{
    
 }

