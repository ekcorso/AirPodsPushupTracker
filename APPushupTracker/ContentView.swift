//
//  ContentView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("60")
                .font(.largeTitle)
                .padding(5)
            Button("Start Counting") {
                // Start the count
            }
//            .clipShape(.capsule)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
