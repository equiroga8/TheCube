//
//  ViewController.swift
//  TheCube
//
//  Created by Edu Quibra on 24/09/2018.
//  Copyright © 2018 Edu Quibra. All rights reserved.
//

import UIKit

struct Constants {
    static let g = 9.8
}
class ViewController: UIViewController, ParametricFunctionViewDataSource {
    
    let cubeModel = CubeModel()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var speedPositionFuncView: FunctionView!
    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var sideSlider: UISlider!
    @IBOutlet weak var accelerationTimeFuncVIew: FunctionView!
    
    @IBOutlet weak var speedTimeFuncView: FunctionView!
    @IBOutlet weak var displacementTimeFuncView: FunctionView!
    
    var trajectoryTime: Double = 0.0 {
        didSet {
            displacementTimeFuncView.setNeedsDisplay()
            speedPositionFuncView.setNeedsDisplay()
            accelerationTimeFuncVIew.setNeedsDisplay()
            speedTimeFuncView.setNeedsDisplay()
        }
    }
    
    func startIndexFor(_ functionView: FunctionView) -> Double {
        switch functionView {
        case displacementTimeFuncView:
            return 0
        case speedTimeFuncView:
            return 0
        case accelerationTimeFuncVIew:
            return 0
        case speedPositionFuncView:
            return 0
        default:
            return 0
        }
        
    }
    
    func endIndexFor(_ functionView: FunctionView) -> Double {
        switch functionView {
        case displacementTimeFuncView:
            return 220
        case speedTimeFuncView:
            return 220
        case accelerationTimeFuncVIew:
            return 220
        case speedPositionFuncView:
            return 220
        default:
            return 1000
        }
    }
    
    func functionView(_ functionView: FunctionView, pointAt index: Double) -> FunctionPoint {
        switch functionView {
        case displacementTimeFuncView:
            let time = index
            let z = cubeModel.positionTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: time, y: z)
        case speedTimeFuncView:
            let time = index
            let v = cubeModel.speedTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: time, y: v)
        case accelerationTimeFuncVIew:
            let time = index
            let a = cubeModel.accelerationTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: time, y: a)
        case speedPositionFuncView:
            let time = index
            let z = cubeModel.positionTimeFunc(side: Double(sideSlider.value), time: time)
            let v = cubeModel.speedTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: z, y: v)
        default:
            return FunctionPoint(x:0,y:0)
        }
    }
    
    func pointsOfInterestFor(_ functionView: FunctionView) -> [FunctionPoint] {
        switch functionView {
        case displacementTimeFuncView:
            return [FunctionPoint(x:0,y:0)]
        case speedTimeFuncView:
            return [FunctionPoint(x:0,y:0)]
        case accelerationTimeFuncVIew:
            return [FunctionPoint(x:0,y:0)]
        case speedPositionFuncView:
            return [FunctionPoint(x:0,y:0)]
        default:
            return [FunctionPoint(x:0,y:0)]
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        displacementTimeFuncView.dataSource = self
        speedTimeFuncView.dataSource = self
        accelerationTimeFuncVIew.dataSource = self
        speedPositionFuncView.dataSource = self
        
        timeSlider.sendActions(for: .valueChanged)
        sideSlider.sendActions(for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sideChanged(_ sender: UISlider) {
        displacementTimeFuncView.setNeedsDisplay()
        speedPositionFuncView.setNeedsDisplay()
        accelerationTimeFuncVIew.setNeedsDisplay()
        speedTimeFuncView.setNeedsDisplay()
    }
    
    @IBAction func timeChanged(_ sender: UISlider) {
        displacementTimeFuncView.setNeedsDisplay()
        speedPositionFuncView.setNeedsDisplay()
        accelerationTimeFuncVIew.setNeedsDisplay()
        speedTimeFuncView.setNeedsDisplay()
    }
    
}

