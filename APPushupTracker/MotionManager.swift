//
//  MotionManager.swift
//  APPushupTracker
//
//  Created by Emily Corso on 5/19/24.
//

import Foundation
import CoreMotion

protocol MotionManagerDelegate: AnyObject {
  func didUpdateAccelerationY(_ accelerationY: Double)
  func didUpdatePitch(_ pitch: Double)
}

class MotionManager {
    private var motionManager = CMHeadphoneMotionManager()
    weak var delegate: MotionManagerDelegate?
    
    var isActive: Bool {
        motionManager.isDeviceMotionActive
    }
    
    var pitch: Double = 0.0 {
        didSet {
            delegate?.didUpdatePitch(pitch)
        }
    }
    
    var accelerationY: Double = 0.0 {
        didSet {
            delegate?.didUpdateAccelerationY(accelerationY)
        }
    }
    
    deinit {
        stopUpdates()
    }
    
    func startUpdates() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion is not available")
            return
        }
       
        if motionManager.isDeviceMotionActive { // TODO: Refactor to use isActive instead
            print("Device motion is already active")
            return
        }
        
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion, error == nil else { // TODO: Rename motion to deviceMotion
                print("An error occured: \(error!.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.pitch = motion.userAcceleration.y
                self.accelerationY = motion.userAcceleration.y
            }
        }
    }
    
    func stopUpdates() {
        guard motionManager.isDeviceMotionActive else { // TODO: Refactor to use isActive instead
            print("Device motion is already stopped")
            return
        }
        
        motionManager.stopDeviceMotionUpdates()
        
        print("[Motion Manager] Stopped updating.")
    }
}