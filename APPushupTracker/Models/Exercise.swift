//
//  Exercise.swift
//  APPushupTracker
//
//  Created by Emily Corso on 8/1/24.
//

import Foundation

protocol Exercise {
    var downAccelerationThreshold: Double { get set }
    var upAccelerationThreshold: Double { get set }
    var pitchThreshold: Double { get set }
}
