//
//  ExerciseChartView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI
import Charts

struct ExerciseChartView: View {
    @State private var viewModel = ExerciseChartViewViewModel()
    @State private var pushupIsSelected = false
    @State private var squatIsSelected = false
    @State private var burpeeIsSelected = false

    
    var body: some View {
        VStack {
            Text("Average pitch: \(decimalFormatter.string(from: viewModel.pushupAvgPitch))")
                .padding(10)
            Text("Average acceleration up: \(decimalFormatter.string(from: viewModel.pushupAvgUpAcceleration))")
                .padding(10)
            Text("Average acceleration down: \(decimalFormatter.string(from: viewModel.pushupAvgDownAcceleration))")
                .padding(10)
            HStack {
                Button("Pushups") {
                    if pushupIsSelected {
                        let exercisesWithoutPushup = viewModel.selectedExercises.filter({ $0 is Pushup })
                        viewModel.selectedExercises = exercisesWithoutPushup
                    } else {
                        viewModel.selectedExercises.append(Pushup.shared)
                    }
                    self.pushupIsSelected.toggle()
                }
                .buttonStyle(.selectable(isSelected: pushupIsSelected))
                .tint(Pushup.shared.signatureColor)

                Button("Squats") {
                    if squatIsSelected {
                        let exercisesWithoutSquat = viewModel.selectedExercises.filter({ $0 is Squat })
                        viewModel.selectedExercises = exercisesWithoutSquat
                    } else {
                        viewModel.selectedExercises.append(Squat.shared)
                    }
                    self.squatIsSelected.toggle()
                }
                .buttonStyle(.selectable(isSelected: squatIsSelected))
                .tint(Squat.shared.signatureColor)

                Button("\(Burpee.shared.name)") {
                    if burpeeIsSelected {
                        let exercisesWithoutBurpee = viewModel.selectedExercises.filter({ $0 is Burpee })
                        viewModel.selectedExercises = exercisesWithoutBurpee
                    } else {
                        viewModel.selectedExercises.append(Burpee.shared)
                    }
                    self.burpeeIsSelected.toggle()
                }
                .buttonStyle(.selectable(isSelected: burpeeIsSelected))
                .tint(Burpee.shared.signatureColor)
            }
            
            Text("Acceleration Data")
            Chart {
                if pushupIsSelected {
                    ForEach(Array(zip(viewModel.pushupAccelerationData.indices, viewModel.pushupAccelerationData)), id: \.0) { item in
                        LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1), series: .value("Pushups", "One"))
                            .foregroundStyle(Pushup.shared.signatureColor)
                    }
                }
                
                if squatIsSelected {
                    ForEach(Array(zip(viewModel.squatAccelerationData.indices, viewModel.squatAccelerationData)), id: \.0) { item in
                        LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1), series: .value("Squats", "Two"))
                            .foregroundStyle(Squat.shared.signatureColor)
                    }
                }
                
                if burpeeIsSelected {
                    ForEach(Array(zip(viewModel.burpeeAccelerationData.indices, viewModel.burpeeAccelerationData)), id: \.0) { item in
                        LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1), series: .value("Burpees", "Two"))
                            .foregroundStyle(Burpee.shared.signatureColor)
                    }
                }
            }
            .chartYAxis() {
                AxisMarks(values: .stride(by: 0.2))
            }
        }
        .onAppear {
            viewModel.refreshDataForSelectedExercises()
        }
    }
}

#Preview {
    ExerciseChartView()
}
