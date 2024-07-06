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
            Button("Print data") {
                print("The averagePitch is: \(dataStorage.avgPitch)")
                print("The pitchData is: \(dataStorage.pitchData)")
                print("The accelerationData is: \(dataStorage.accelerationData)")
            }
            Text("Acceleration Data")
            Chart {
                ForEach(Array(zip(dataStorage.accelerationData.indices, dataStorage.accelerationData)), id: \.0) { item in
                    LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1))
                }
            }
            .chartYAxis() {
                AxisMarks(values: .stride(by: 0.2))
            }
        }
    }
}

#Preview {
    PushupChartView()
        .environmentObject(DataStorage())
}
