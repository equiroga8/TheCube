//
//  DisplacementVIew.swift
//  Cube
//
//  Created by Edu Quibra on 18/09/2018.
//  Copyright © 2018 Edu Quibra. All rights reserved.
//

import UIKit

@IBDesignable
class FunctionView: UIView {
    
    let TICK_LENGTH = CGFloat(3)
    
    override func draw(_ rect: CGRect){
        let width = bounds.size.width
        let height = bounds.size.height
        drawAxis(width, height)
        drawTicks(width, height)
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
    
}

