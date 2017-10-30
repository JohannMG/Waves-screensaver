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
    
    let kBarWidth: CGFloat = 40
    let kMotionDampening:Float = 0.1
    let kTwineThickness: CGFloat = 1.0
    
    let kTwineColor = CGColor(gray: 0.8, alpha: 1.0)
    let kPivotColor = CGColor(red: 1.0, green: 0.1, blue: 0.1, alpha: 0.7)
    
    var bars = [Bar]()
    
    func setup(){
        let barsThatCanFit:Int = Int( floor(bounds.width / kBarWidth) )
        
        for _ in (0..<barsThatCanFit) {
            bars.append( Bar(withPivotsCount: 2, min: Int(bounds.minY), max: Int(bounds.maxY)) )
        }
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        bars.forEach { (bar: Bar) in
            bar.update(withNoiseRatio: kMotionDampening)
        }
        
        if let context = NSGraphicsContext.current?.cgContext {
            drawLines(withContext: context)
            drawBackRect(withContext: context)
        }
    }
    
    func animateOneFrame(){

    }
    
    func drawLines(withContext context: CGContext){
//        for i in (0..<bars.count) {
//
//        }
    }
    
    func drawTwineInRect(_ rect: CGRect, withContext context: CGContext){
        let path = CGMutablePath()
        path.move(to:CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to:CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        
        context.setLineWidth(kTwineThickness)
        context.setStrokeColor(kTwineColor)
        
        context.addPath(path)
        context.drawPath(using: .stroke)
    }
    
    func drawBackRect(withContext context: CGContext){
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addRect(frame)
        
        path.closeSubpath()
        
        context.setFillColor(CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2))
        context.addPath(path)
        context.drawPath(using: .fill)
    }
    
}
