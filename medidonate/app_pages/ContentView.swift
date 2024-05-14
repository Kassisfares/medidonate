//
//  ContentView.swift
//  medidonate
//
//  Created by fares kassis on 14/5/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTimestamp: TimeInterval = Date().timeIntervalSince1970
    @State private var formattedDate: String = ""
    
    var body: some View {
        VStack {
            Text("Current Timestamp: \(currentTimestamp)")
            Text("Formatted Date: \(formattedDate)")
        }
        .onAppear {
            // Verify the current timestamp and corresponding date
            let currentDate = Date(timeIntervalSince1970: currentTimestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            formattedDate = dateFormatter.string(from: currentDate)
            
            print("Current Timestamp: \(currentTimestamp)")
            print("Formatted Date: \(formattedDate)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
