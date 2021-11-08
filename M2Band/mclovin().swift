//
//  mclovin().swift
//  M2Band
//
//  Created by Luke Fanizzi on 10/26/21.
//

import SwiftUI

struct mclovin__: View {
    var body: some View {
        Image("mclovin").clipShape(Circle()).overlay(Circle().stroke(Color.gray,lineWidth: 4))
    }
}

struct mclovin___Previews: PreviewProvider {
    static var previews: some View {
        mclovin__()
    }
}
