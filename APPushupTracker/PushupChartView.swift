//
//  PushupChartView.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/20/24.
//

import SwiftUI
import Charts

struct PushupChartView: View {
    @State private var data: [Double]  = [9, 6, 7, 4, 6, 2, 9, 6, 7, 4, 6, 2, 9, 6, 7, 4, 6, 2]
    
    var body: some View {
        Chart {
            ForEach(Array(zip(data.indices, data)), id: \.0) { item in
                LineMark(x: .value("Index", item.0), y: .value("Acceleration", item.1))
            }
        }
    }
}

#Preview {
    PushupChartView()
}
