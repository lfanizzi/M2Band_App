//
//  Created by Luke Fanizzi on 11/8/21.
//

import SwiftUI

struct Main_Screen: View {
    var body: some View {
        VStack{
        Text("Main Screen")
            
            Button(action:{} ){
            Text("Hit me!")
                Link("Visit Apple", destination: URL(string: "https://www.apple.com")!)
                    .font(.title)
                    .foregroundColor(.red)
                
        }
        }
    }
}

struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
    }
}
