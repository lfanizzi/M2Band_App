//
//  DataCom.swift
//  M2Band
//
//  Created by Luke Fanizzi on 3/8/22.
//
import SwiftUI
import Foundation
import UIKit

struct DataCom: View {
    
    @State var results = [TaskEntry]()
  
    var body: some View {
        Text("Here is the Fetched Data: ").padding().font(.title)
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.title)
            }
        }.onAppear(perform: loadData)
    }
    


    func loadData() {
        guard let url = URL(string: "https://m2band.hopto.org/") else {
            print("Your API end point is Invalid")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([TaskEntry].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    



struct TaskEntry: Codable  {
    let id: Int
    let title: String
}
}

