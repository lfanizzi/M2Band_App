//
//  band.swift
//  M2Band
//
//  Created by Luke Fanizzi on 10/26/21.
//

import SwiftUI

struct band: View {
    var body: some View {
        Image("band")  .resizable().frame(width: 300.0, height: 350.0)
        .overlay(Circle().stroke(Color.gray,lineWidth: 4)).clipShape(Circle())
    }
}

struct band_Previews: PreviewProvider {
    static var previews: some View {
        band()
    }
}
