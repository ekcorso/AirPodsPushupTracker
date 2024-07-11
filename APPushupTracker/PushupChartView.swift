//
//  PushupChartView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI
import Charts

struct PushupChartView: View {
    @Environment(PushupChartViewViewModel.self) private var viewModel
    
    var body: some View {
        VStack {
            Text("Average pitch: \(viewModel.avgPitch)")
                .padding(10)
            Text("Average acceleration up: \(viewModel.avgUpAcceleration)")
                .padding(10)
            Text("Average acceleration down: \(viewModel.avgDownAcceleration)")
                .padding(10)
            Button("Print data") {
                print("The averagePitch is: \(viewModel.avgPitch)")
                print("The pitchData is: \(viewModel.pitchData)")
                print("The accelerationData is: \(viewModel.accelerationData)")
            }
            Text("Acceleration Data")
            Chart {
                ForEach(Array(zip(viewModel.accelerationData.indices, viewModel.accelerationData)), id: \.0) { item in
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
        .environment(PushupChartViewViewModel())
}
