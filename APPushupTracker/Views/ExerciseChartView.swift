//
//  ExerciseChartView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI
import Charts

// Rename to ChartView? Need to inject model type...
struct ExerciseChartView: View {
    @State private var viewModel = PushupChartViewViewModel()
    
    var body: some View {
        VStack {
            Text("Average pitch: \(decimalFormatter.string(from: viewModel.avgPitch))")
                .padding(10)
            Text("Average acceleration up: \(decimalFormatter.string(from: viewModel.avgUpAcceleration))")
                .padding(10)
            Text("Average acceleration down: \(decimalFormatter.string(from: viewModel.avgDownAcceleration))")
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
        .onAppear {
            viewModel.updateAllProperties()
        }
    }
}

#Preview {
    ExerciseChartView()
}
