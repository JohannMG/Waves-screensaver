//
//  Artbox.swift
//  Wave
//
//  Created by Johann Garces on 10/29/17.
//  Copyright © 2017 johannmg. All rights reserved.
//

import Cocoa
import ScreenSaver

class ArtBox : NSView {
    
    var kBarWidth: CGFloat {
        get {
            if isPreview { return 20 }
            return 50
        }
    }
    let kMotionDampening:Float = 0.01
    let kTwineThickness: CGFloat = 0.5
    let kPivotHeight: CGFloat = 14.0
    let kPivotWidth: CGFloat = 5.0
    let kPivotsPerTwine = 2
    let kConnectorThickness: CGFloat = 0.5
    
    let kTwineColor = CGColor(gray: 0.8, alpha: 1.0)
    let kPivotColor = CGColor(red: 1.0, green: 0.1, blue: 0.1, alpha: 0.6)
    let kConnectorColor = CGColor(red: 0.7, green: 0.7, blue: 0.87, alpha: 0.8)
    
    private(set) var bars = [Bar]()
    private(set) var isSetup = false
    var isPreview = false
    
    func setup(){
        if isSetup { return }
        let barsThatCanFit:Int = Int( floor(bounds.width / kBarWidth) )
        if barsThatCanFit > 0 { isSetup = true }
        
        for _ in (0..<barsThatCanFit) {
            bars.append( Bar(withPivotsCount: kPivotsPerTwine, min: Int(bounds.minY), max: Int(bounds.maxY)) )
        }
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        bars.forEach { $0.update(withNoiseRatio: kMotionDampening) }
        
        drawLines(withContext: NSGraphicsContext.current!.cgContext)
        drawConnectors(withContext: NSGraphicsContext.current!.cgContext)
        drawPivotsToContext(context: NSGraphicsContext.current!.cgContext)
    }
    
    func animateOneFrame(){

    }
    
    func drawLines(withContext context: CGContext){
        for i in (0..<bars.count) {
            let subRect = CGRect(x: kBarWidth * CGFloat(i), y: 0, width: kBarWidth, height: frame.height)
            drawTwineInRect( subRect , withContext: context)
        }
    }
    
    func drawTwineInRect(_ rect: CGRect, withContext context: CGContext){
        let path = CGMutablePath()
        path.move(to:CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to:CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        
        context.setLineWidth(kTwineThickness)
        context.setStrokeColor(kTwineColor)

        context.addPath(path)
        context.drawPath(using: .stroke)
    }
    
    func drawConnectors(withContext context: CGContext){
        for pivotSeries in (0..<kPivotsPerTwine){
            let path = CGMutablePath()
            
            for bar in (0..<bars.count){
                let point = CGPoint(x: (kBarWidth/2.0) + (CGFloat(bar) * kBarWidth),
                                    y: CGFloat(bars[bar].values[pivotSeries]))
                if bar == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            
            path.closeSubpath()
            context.addPath(path)
            context.setLineWidth(kConnectorThickness)
            context.setStrokeColor(kConnectorColor)
            context.drawPath(using: .stroke)
        }
    }
    
    func drawPivotsToContext(context: CGContext){
        for pivot in (0..<kPivotsPerTwine){
            for i in (0..<bars.count){
                drawPivotToContext(context: context, atColumn: i, withValue: Float(bars[i].values[pivot]))
            }
        }
        context.setLineWidth(kPivotWidth)
        context.setStrokeColor(kPivotColor)
        context.drawPath(using: .stroke)
    }

    private func drawPivotToContext(context: CGContext, atColumn column: Int, withValue value: Float){
        let path = CGMutablePath()
        let xOffset = (kBarWidth/2.0) + (CGFloat(column) * kBarWidth)
        path.move(to: CGPoint(x: xOffset, y: CGFloat(value) - (kPivotHeight/2.0) ))
        path.addLine(to: CGPoint(x: xOffset, y: CGFloat(value) + (kPivotHeight/2.0)))
        path.closeSubpath()
        context.addPath(path)
    }
//
//    func drawBackRect(withContext context: CGContext){
//        let path = CGMutablePath()
//        path.addRect(frame)
//
//        path.closeSubpath()
//
//        context.setFillColor(CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2))
//        context.addPath(path)
//        context.drawPath(using: .fill)
//    }
    
}
