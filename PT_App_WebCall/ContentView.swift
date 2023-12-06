//
//  ContentView.swift
//  PT_App_WebCall
//
//  Created by Tucker Hawkins on 11/17/23.
//

import SwiftUI

class WebCall {
    let url = URL(string: "https://www.webservices.parktudorcs.org/api/TodoItems")!
    func loadText(completion:@escaping (String) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print(data)
                let text1 = String(data: data, encoding: .utf8)
                print(text1 ?? "Blank")
                DispatchQueue.main.async {
                    completion(text1 ?? "Loaded")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
            .resume()
    }
}


struct ContentView: View {
    @State var text1: String?
    var body: some View {
        VStack {
            Text(text1 ?? "Not loaded")
        }.onAppear() {
            WebCall().loadText { (text1) in
                self.text1 = text1
            }
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
