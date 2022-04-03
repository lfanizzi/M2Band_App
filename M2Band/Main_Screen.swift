//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI
import CoreBluetooth
import CoreGraphics
import UIKit



//var Progress = 0
//@main
//@State var progressValue: Float = 0.0

struct Main_Screen: View{
    
   // @State var data1 = ""
   // @State var indexing = 0
   // @State var tempvar = ""
   // @State var heart2 = 0
   // var components : Array<String> = Array()
    @State public var user_id = ""
    @State public var Progress = 0//87
    @State public var BT = false
    @State var heart  = 0//81
    @State public var O2 = 0//98
    @State public var steps = 0//2156
    @State public var temp = 0.0//98
    @State public var login2 = false//true
    var body: some View {
        if (login2){
            Login(user_id: $user_id, login2: $login2)
        }
        else{
        NavigationView{
    ZStack{
       
        Color(.gray).opacity(0.2).edgesIgnoringSafeArea(.all)
        VStack(spacing: 1){
            
            Text("M2Band").fontWeight(.bold).font(.title).frame(width: 120, height: 80, alignment: .topLeading)
            
            Image("band").resizable().frame(width: 75, height: 75).padding()
            //Spacer()
           // List{
            HStack{
                Text("  Heart Rate (BPM) :    ").fontWeight(.bold).foregroundColor(.red).frame(alignment: .leading)
                Text("\(heart)").fontWeight(.bold).padding().foregroundColor(.red).padding().frame(alignment: .center)
                Spacer()
                Image("heart_icon").resizable().frame(width: 25, height: 25).padding()
            }
            HStack{
                Text("  Blood O2 Level:    ").fontWeight(.bold).foregroundColor(.blue).frame(alignment: .leading)
                Text("\(O2)").fontWeight(.bold).padding().foregroundColor(.blue).padding().frame(alignment: .center)
                Spacer()
                Image("oxy_icon").resizable().frame(width: 50, height: 35).padding()
            }
            HStack{
                Text("  Steps:                 ").fontWeight(.bold).foregroundColor(.green).frame(alignment: .leading)
                Text("\(steps)").fontWeight(.bold).padding().foregroundColor(.green).padding().frame(alignment: .center)
                Spacer()
                Image("steps_icon").resizable().frame(width: 50, height: 35).padding()
            }
            HStack{
                Text("  Temperature:      ").fontWeight(.bold).foregroundColor(.orange).frame(alignment: .leading)
                Text("\(Int(temp))").fontWeight(.bold).padding().foregroundColor(.orange).padding().frame(alignment: .center)
                Spacer()
                Image("thermo_icon").resizable().frame(width: 75, height: 75)
            }
            
            HStack{
                Text("  Progress:               ").fontWeight(.bold).foregroundColor(.yellow).frame(alignment: .leading)
                Text("\(Progress)").fontWeight(.bold).padding().foregroundColor(.yellow).padding().frame(alignment: .center)
                Spacer()
                Image("progress_icon").resizable().frame(width: 50, height: 50).padding()
            }
            
            
                 HStack {
                     
                     NavigationLink(destination: settings()) {
                         
                         Image("gear2").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                         
                     }.buttonStyle(ThemeAnimationStyle()).padding()
                     
                     NavigationLink(destination: Login(user_id:$user_id, login2: $login2)) {
                        Image("profile").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                     }.buttonStyle(ThemeAnimationStyle()).padding()
                     
                     NavigationLink(destination: history()) {
                         Image("history").resizable().renderingMode(.original).frame(width: 50, height: 50, alignment: .leading).foregroundColor(.blue)
                     }.buttonStyle(ThemeAnimationStyle()).padding()
                     
                     
                 }.frame(height: 100)//.transition(.move(edge: .top)).animation(.easeIn(duration: 5))
            
            /*NavigationLink( destination: ServerCom(heart: $heart, O2:$O2, steps:$steps, temp:$temp, user_id: $user_id)){
                 Text("Fetch Data").bold().padding()
            }*/
            
                //NavigationLink(destination: Login(user_id: //$user_id, login2: $login2)){
                //Text("Logout").bold().padding()
                
           // }
          //  } //end of list
            
          }
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

struct ThemeAnimationStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title2)
            .foregroundColor(Color.white)
            .frame(height: 50, alignment: .center)
            .background(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            .cornerRadius(8)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) //<- change scale value as per need. scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}
