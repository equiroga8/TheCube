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
        return 0
        
    }
    
    func endIndexFor(_ functionView: FunctionView) -> Double {
        return 10
    }
    
    func functionView(_ functionView: FunctionView, pointAt index: Double) -> FunctionPoint {
        let time = index
        switch functionView {
        case displacementTimeFuncView:
            let z = cubeModel.positionTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: time, y: z)
        case speedTimeFuncView:
            let v = cubeModel.speedTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: time, y: v)
        case accelerationTimeFuncVIew:
            let a = cubeModel.accelerationTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: time, y: a)
        case speedPositionFuncView:
            let z = cubeModel.positionTimeFunc(side: Double(sideSlider.value), time: time)
            let v = cubeModel.speedTimeFunc(side: Double(sideSlider.value), time: time)
            return FunctionPoint(x: z, y: v)
        default:
            return FunctionPoint(x:0,y:0)
        }
    }
    
    func pointsOfInterestFor(_ functionView: FunctionView) -> [FunctionPoint] {
        let time = Double(timeSlider.value)
        switch functionView {
        case displacementTimeFuncView:
            let z = cubeModel.positionTimeFunc(side: Double(sideSlider.value), time: time)
            return [FunctionPoint(x: time, y: z)]
        case speedTimeFuncView:
            let v = cubeModel.speedTimeFunc(side: Double(sideSlider.value), time: time)
            return [FunctionPoint(x: time, y: v)]
        case accelerationTimeFuncVIew:
            let a = cubeModel.accelerationTimeFunc(side: Double(sideSlider.value), time: time)
            return [FunctionPoint(x: time, y: a)]
        case speedPositionFuncView:
            let z = cubeModel.positionTimeFunc(side: Double(sideSlider.value), time: time)
            let v = cubeModel.speedTimeFunc(side: Double(sideSlider.value), time: time)
            return [FunctionPoint(x: z, y: v)]
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

