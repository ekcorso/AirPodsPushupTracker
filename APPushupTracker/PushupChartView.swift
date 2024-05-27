//
//  PushupChartView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI
import Charts

struct PushupChartView: View {
    @State private var accellerationData: [Double]  = [9, 6, 7, 4, 6, 2, 9, 6, 7, 4, 6, 2, 9, 6, 7, 4, 6, 2]
    @State private var pitchData = [1, 1.5, 1.2, 1, 1, 1, 0.8, 1.1, 1.02, 0.95, 1]
    @State private var averagePitch = 0
    
    var body: some View {
        VStack {
            Text("Average pitch: \(averagePitch)")
                .padding(30)
            Chart {
                ForEach(Array(zip(accellerationData.indices, accellerationData)), id: \.0) { item in
                    LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1))
                }
            }
        }
    }
}

#Preview {
    PushupChartView()
}
