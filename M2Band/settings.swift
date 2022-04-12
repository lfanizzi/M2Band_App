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
    
    var body: some View{
        VStack{
            Image("gear2").resizable().renderingMode(.original).frame(width:100, height: 100).padding()
            Text("Settings").font(.title2).bold().padding()
            
            ScrollView{
                Button("Change Password"){
                    change_pass(user_id: user_id)
                }.padding()
                Button("Change Theme"){
                    
                }.padding()
            }
        }
    }
    
}

func change_pass(user_id: String ){
    
}
