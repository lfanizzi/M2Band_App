//
//  Launch_Screen2.swift
//  M2Band
//
//  Created by Luke Fanizzi on 3/31/22.
//

import CoreBluetooth
import CoreGraphics
import UIKit
import Foundation
import SwiftUI


struct Launch_Screen2: View{
    @State var popUp = true
    @Binding public var launch2 : Bool
    var spinner = SpinnerViewController()
    var body: some View{
        ZStack{
           
            VStack{
                Text("This app uses Cookies").font(.title).bold().padding()
             
                if(popUp){
                    Image("ang").resizable().frame(width: 200, height: 250)
                }
                Text("Would you like to accept cookies?")
               
                
                     HStack {
                         
                         Button("Cooki"){
                            // spinner.createSpinnerView()
                             launch2 = false
                            
                         }.frame(width:60, height:40, alignment: .center).border(.black, width: 2).padding()
                     
                         Button("No Cooki" ){
                             //spinner.createSpinnerView()
                             launch2 = false
                         }.frame(width:100, height:40, alignment: .center).border(.black, width: 2).padding()
                     }
                
            }
           
        }
        
        
    }
    
    
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

public func createSpinnerView() {
    let child = SpinnerViewController()

    // add the spinner view controller
    addChild(child)
    child.view.frame = view.frame
    view.addSubview(child.view)
    child.didMove(toParent: self)

    // wait two seconds to simulate some work happening
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        // then remove the spinner view controller
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
}
/*
 Button("Cooki?"){
     popUp = true
 
 }
 
 ///
.alert(isPresented:$popUp){
    

Alert(

    title: Text("Warning: This app uses cookies."),
message:Text("Would you like to accept these cookies?"),
primaryButton: .destructive(Text("Yes")){
    launch2 = false
},
secondaryButton: .destructive(Text("No")){
    launch2 = false
}
)

}
*/


