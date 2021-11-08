//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI
var heart = 0
var O2 = 0
var steps = 0
var Progress = 1
struct Main_Screen: View {
    var body: some View {
        VStack{
            Text("M2Band").fontWeight(.bold).padding().font(.largeTitle)
            
            Text("Heart Rate (BPM) : \(heart)").fontWeight(.bold).padding().foregroundColor(.red)
            Text("Blood O2 Level: \(O2)").fontWeight(.bold).padding().foregroundColor(.blue)
            Text("Steps: \(steps)").fontWeight(.bold).padding().foregroundColor(.green)
            Text("Progress: \(Progress)").fontWeight(.bold).padding()
            
            Button(action:{} ){
            Text("Refresh App")
                
                
        }
        }
    }
}

struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
    }
}
