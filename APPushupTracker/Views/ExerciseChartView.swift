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
    
    var body: some View {
        VStack {
            Text("Average pitch: \(decimalFormatter.string(from: viewModel.pushupAvgPitch))")
                .padding(10)
            Text("Average acceleration up: \(decimalFormatter.string(from: viewModel.pushupAvgUpAcceleration))")
                .padding(10)
            Text("Average acceleration down: \(decimalFormatter.string(from: viewModel.pushupAvgDownAcceleration))")
                .padding(10)
            Button("Print data") {
                print("The averagePitch is: \(viewModel.pushupAvgPitch)")
                print("The pitchData is: \(viewModel.pushupPitchData)")
                print("The accelerationData is: \(viewModel.pushupAccelerationData)")
            }
            
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
                .padding(10)
                .font(.headline)
                .foregroundStyle(.white)
                .background(Pushup.shared.signatureColor)
                .clipShape(.buttonBorder)
                
                Button("Squats") {
                    if squatIsSelected {
                        let exercisesWithoutSquat = viewModel.selectedExercises.filter({ $0 is Squat })
                        viewModel.selectedExercises = exercisesWithoutSquat
                    } else {
                        viewModel.selectedExercises.append(Squat.shared)
                    }
                    self.squatIsSelected.toggle()
                }
                .padding(10)
                .font(.headline)
                .foregroundStyle(.white)
                .background(Squat.shared.signatureColor)
                .clipShape(.buttonBorder)

                Button("Situps") {
//                    viewModel.selectedExercises.append(Situp.shared)
                }
                .disabled(true)
                .padding(10)
                .font(.headline)
                .foregroundStyle(.white)
                .background(.orange)
                .clipShape(.buttonBorder)
            }
            
            Text("Acceleration Data")
            Chart {
                ForEach(Array(zip(viewModel.pushupAccelerationData.indices, viewModel.pushupAccelerationData)), id: \.0) { item in
                    LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1))
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
