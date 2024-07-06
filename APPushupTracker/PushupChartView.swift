//
//  PushupChartView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI
import Charts

struct PushupChartView: View {
    @EnvironmentObject var dataStorage: DataStorage
    
    var body: some View {
        VStack {
            Text("Average pitch: \(dataStorage.avgPitch)")
                .padding(10)
            Text("Average acceleration up: \(dataStorage.avgUpAcceleration)")
                .padding(10)
            Text("Average acceleration down: \(dataStorage.avgDownAcceleration)")
                .padding(10)
            Text("Acceleration Data")
            Chart {
                ForEach(Array(zip(dataStorage.accelerationData.indices, dataStorage.accelerationData)), id: \.0) { item in
                    LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1))
                }
            }
        }
    }
}

#Preview {
    PushupChartView()
        .environmentObject(DataStorage())
}
