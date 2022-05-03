//
//  M2BandApp.swift
//  M2Band
//
//  Created by Luke Fanizzi on 10/19/21.
//

import SwiftUI
import CoreBluetooth
import Foundation

var i = 0
@main

struct M2BandApp: App {
    @State public var launch2 = false //true
    @State public var login2 = false//true
    var body: some Scene {
        
        WindowGroup{
           
            if(launch2){
                Launch_Screen2(launch2: $launch2)
            }
          //  if(login2){
            //    Login()
           // }
            else{
                Main_Screen()//.transition(.move(edge: .bottom).animation(.easeInOut(duration: 5)))
                
            }
            
           // switchViews(is_BT: changeBT(BT: get_is_BT()))
            

        }
        
        }
    
    
   
      
    
   
    
}


@ViewBuilder public func switchViews(is_BT : Bool ) -> some View{
    
    if(!is_BT){
       Main_Screen()
    }
   
}
public func showBT(butt : Bool) -> Void{
    
 }

