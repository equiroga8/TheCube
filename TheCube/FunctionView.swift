//
//  DisplacementVIew.swift
//  Cube
//
//  Created by Edu Quibra on 18/09/2018.
//  Copyright © 2018 Edu Quibra. All rights reserved.
//

import UIKit
struct FunctionPoint {
    var x = 0.0
    var y = 0.0
}

protocol ParametricFunctionViewDataSource: class {
    func startIndexFor(_ functionView: FunctionView) -> Double
    func endIndexFor(_ functionView: FunctionView) -> Double
    func functionView(_ functionView: FunctionView, pointAt index: Double) -> FunctionPoint
    func pointsOfInterestFor(_ functionView: FunctionView) -> [FunctionPoint]
}

@IBDesignable
class FunctionView: UIView {
    
    @IBInspectable
    var lineWidth: Double = 3.0
    
    @IBInspectable
    var trajectoryColor: UIColor = UIColor.red
    
    @IBInspectable
    var textX: String = "x"
    
    @IBInspectable
    var textY: String = "y"
    
    @IBInspectable
    var scaleX: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var scaleY: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var resolution: Double = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    #if TARGET_INTERFACE_BUILDER
    var dataSource: ParametricFunctionViewDataSource!
    #else
    weak var dataSource: ParametricFunctionViewDataSource!
    #endif
    
    override func prepareForInterfaceBuilder() {
        class FakeDataSource: ParametricFunctionViewDataSource {
            func startIndexFor(_ functionView: FunctionView) -> Double {
                return 0.0
            }
            
            func endIndexFor(_ functionView: FunctionView) -> Double {
                return 1.0
            }
            
            func functionView(_ functionView: FunctionView, pointAt index: Double) -> FunctionPoint {
                return FunctionPoint(x: index, y: index)
            }
            
            func pointsOfInterestFor(_ functionView: FunctionView) -> [FunctionPoint] {
                return []
            }
        }
    }
    let TICK_LENGTH = CGFloat(3)
    
    override func draw(_ rect: CGRect){
        let width = bounds.size.width
        let height = bounds.size.height
        drawAxis(width, height)
        drawTicks(width, height)
        drawTexts(width, height)
        drawTrayectory()
        drawPOI()
    }
    
    private func drawAxis(_ width: CGFloat,_ height: CGFloat){
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: width/2, y: 0))
        path1.addLine(to: CGPoint(x: width/2, y: height))
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: height/2))
        path2.addLine(to: CGPoint(x: width, y: height/2))
        
        UIColor.black.setStroke()
        
        path1.lineWidth = 1
        path1.stroke()
        path2.lineWidth = 1
        path2.stroke()
        
    }
    private func drawTicks(_ width: CGFloat,_ height: CGFloat){
        let xInterval = width/11
        let yInterval = height/11
        
        for i in stride(from: xInterval/2, to: width, by: xInterval){
            let path = UIBezierPath()
            path.move(to: CGPoint(x: i, y: height/2 - TICK_LENGTH))
            path.addLine(to: CGPoint(x: i, y: height/2 + TICK_LENGTH))
            path.lineWidth = 1
            path.stroke()
        }
        
        for i in stride(from: yInterval/2, to: width, by: yInterval){
            let path = UIBezierPath()
            path.move(to: CGPoint(x: width/2 - TICK_LENGTH, y: i))
            path.addLine(to: CGPoint(x: width/2 + TICK_LENGTH, y: i))
            path.lineWidth = 1
            path.stroke()
        }
        
    }
    
    private func drawTexts(_ width: CGFloat,_ height: CGFloat){
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let offset: CGFloat = 4
        let asX = NSAttributedString(string: textX, attributes: attrs)
        let sizeX = asX.size()
        let posX = CGPoint(x: width - sizeX.width - offset, y: height/2 + offset)
        asX.draw(at: posX)
        
        let asY = NSAttributedString(string: textY, attributes: attrs)
        let posY = CGPoint(x: width/2 + offset, y: offset)
        asY.draw(at: posY)
    }
    
    private func drawTrayectory() {
        if dataSource == nil {
            return
        }
        let startTime = dataSource.startIndexFor(self)
        let endTime = dataSource.endIndexFor(self)
        let incrTime = max((endTime - startTime) / resolution, 0.01)
        
        let path = UIBezierPath()
        
        var point = dataSource.functionView(self, pointAt: startTime)
        var px = pointForX(point.x)
        var py = pointForY(point.y)
        path.move(to: CGPoint(x: px, y: py))
        
        for t in stride(from: startTime, to: endTime, by: incrTime){
            point = dataSource.functionView(self, pointAt: t)
            px = pointForX(point.x)
            py = pointForY(point.y)
            path.addLine(to: CGPoint(x: px, y: py))
        }
        
        point = dataSource.functionView(self, pointAt: endTime)
        px = pointForX(point.x)
        py = pointForY(point.y)
        path.move(to: CGPoint(x: px, y: py))
        
        path.lineWidth = CGFloat(lineWidth)
        trajectoryColor.set()
        path.stroke()
    }
    
    private func drawPOI() {
        for p in dataSource.pointsOfInterestFor(self) {
            let px = pointForX(p.x)
            let py = pointForY(p.y)
            
            let path = UIBezierPath(ovalIn: CGRect(x: px - 4, y: py - 4, width: 8, height: 8))
            UIColor.black.set()
            path.stroke()
            path.fill()
        }
    }
    
    private func pointForX(_ x: Double) -> CGFloat {
        let width = bounds.size.width
        return width/2 + CGFloat(x * scaleX)
    }
    
    private func pointForY(_ y: Double) -> CGFloat {
        let height = bounds.size.height
        return height/2 - CGFloat(y * scaleY)
    }
}

