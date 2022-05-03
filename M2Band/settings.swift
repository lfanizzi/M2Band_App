//
//  settings.swift
//  M2Band
//
//  Created by Luke Fanizzi on 4/3/22.
//

import Foundation
import CoreBluetooth
import CoreGraphics
import UIKit
import Foundation
import SwiftUI

struct settings: View{
    @Binding public var user_id : String
    @Binding public var Progress : String
    @Binding public var goal : String
    @State var change = false
    var body: some View{
        VStack{
            Image("gear2").resizable().renderingMode(.original).frame(width:100, height: 100).padding()
            Text("Settings").font(.title2).bold().padding()
            
            ScrollView{
                //Button("Change Password"){
                    //change_pass(user_id: user_id)
                //}.padding()
                Text("Goal: \(goal) steps").font(.title3).foregroundColor(.orange).bold().padding()
                
                Button("Change Goal"){
                    change = !change
                }
                if change{
                    TextField("Goal", text: $goal)
                    Button("Submit Changes"){
                        change = !change
                        
                    }
                }
            }
        }
    }
    
}

func change_pass(user_id: String ){
    
}
