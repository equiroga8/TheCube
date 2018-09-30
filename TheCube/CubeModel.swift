//
//  CubeModel.swift
//  TheCube
//
//  Created by Edu Quibra on 29/09/2018.
//  Copyright © 2018 Edu Quibra. All rights reserved.
//

import Foundation

class CubeModel {
    
    func positionTimeFunc(side: Double, time: Double) -> Double {
        let w = angularFrecuency(side: side)
        return 0.5*side*cos(w*time)

    }
    
    func speedTimeFunc(side: Double, time: Double) -> Double {
        let w = angularFrecuency(side: side)
        return -0.5*side*w*sin(w*time)
    }
    
    func accelerationTimeFunc(side: Double, time: Double) -> Double {
        let w = angularFrecuency(side: side)
        return -Constants.g*cos(w*time)
    }
    
    func speedPositionFunc(side: Double, time: Double) -> Double {
        let w = angularFrecuency(side: side)
        return -tan(w*time)
    }
    
    private func angularFrecuency(side : Double) -> Double {
        return sqrt(2*Constants.g/side)
    }
    
    
}
