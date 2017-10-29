//  Bar.swift
// Johann Garces / JohannMG

import Foundation
import Cocoa
import ScreenSaver

/*
     Data representation of each bar
 */
class Bar {
    //Number of spots tracked
    var pivots: uint8 = 0
    var values = [Int]()
    let max: Int!
    let min: Int!
    
    init() {
        fatalError("ohno")
    }
    
    init(withPivotsCount count: Int, startValue: Int, min: Int, max: Int){
        for _ in (0..<count) { values.append(startValue) }
        self.min = min
        self.max = max
    }
    
    convenience init(withPivotsCount count: Int, min: Int, max: Int){
        let startValue = (max - min) / 2
        self.init(withPivotsCount: count, startValue: startValue, min: min, max: max)
    }
    
    func update(withNoiseRatio ratio: Float){
        values = values.map { (value: Int) -> Int in
            let randomIntInRange = SSRandomIntBetween( Int32(min-max), Int32(max-min))
            let delta = Float(randomIntInRange) * ratio
            return value + Int(delta)
        }
    }
}
