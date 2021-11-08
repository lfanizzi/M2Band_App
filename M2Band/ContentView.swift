//
//  ContentView.swift
//  M2Band
//
//  Created by Luke Fanizzi on 10/19/21.
//

import SwiftUI
import AssetsLibrary
import ImageIO

struct ContentView: View {
    var body: some View {
        VStack{
            Image("band").frame(width: 250, height: 200 ).clipShape(Circle()).overlay(Circle().stroke(Color.gray,lineWidth: 4))
            
            Text("Welcome to M2Band")
                .fontWeight(.bold).foregroundColor(.green).font(.title)
        
            Text("Devloped by Team Greenies").fontWeight(.light).foregroundColor(.green)
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
