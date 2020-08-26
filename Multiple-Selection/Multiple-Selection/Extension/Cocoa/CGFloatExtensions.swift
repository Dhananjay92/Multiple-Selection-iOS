//
//  CGFloatExtensions.swift
//  EZSwiftExtensions
//
//  Created by Cem Olcay on 12/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension CGFloat {

    /// EZSE: Return the central value of CGFloat.
    public var center: CGFloat { return (self / 2) }

    public func toRadians() -> CGFloat {
        return (CGFloat.pi * self) / 180.0
    }

    /// EZSwiftExtensions
    public func degreesToRadians() -> CGFloat {
        return (CGFloat.pi * self) / 180.0
    }

    /// EZSwiftExtensions
    public mutating func toRadiansInPlace() {
        self = (CGFloat.pi * self) / 180.0
    }

    /// EZSE: Converts angle degrees to radians.
    public static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (CGFloat.pi * angle) / 180.0
    }

    /// EZSE: Converts radians to degrees.
    public func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / CGFloat.pi
    }

    /// EZSE: Converts angle radians to degrees mutable version.
    public mutating func toDegreesInPlace() {
        self = (180.0 * self) / CGFloat.pi
    }

    /// EZSE : Converts angle radians to degrees static version.
    public static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / CGFloat.pi
    }
    
    /// EZSE: Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
        
    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /**
      EZSE :Returns the shortest angle between two angles. The result is always between
      -π and π.
     
      Inspired from : https://github.com/raywenderlich/SKTUtils/blob/master/SKTUtils/CGFloat%2BExtensions.swift
     */
    public static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if (angle >= .pi) {
            angle = angle - twoPi
        }
        if (angle <= -.pi) {
            angle = angle + twoPi
        }
        return angle
    }
}

// MARK: - Properties
extension CGFloat {
    
    /// SwifterSwift: Absolute of CGFloat value.
    public var abs: CGFloat {
        return Swift.abs(self)
    }
    
    /// SwifterSwift: Ceil of CGFloat value.
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// SwifterSwift: Floor of CGFloat value.
    public var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// SwifterSwift: Check if CGFloat is positive.
    public var isPositive: Bool {
        return self > 0
    }
    
    /// SwifterSwift: Check if CGFloat is negative.
    public var isNegative: Bool {
        return self < 0
    }
    
    /// SwifterSwift: Int.
    public var int: Int {
        return Int(self)
    }
    
    /// SwifterSwift: Float.
    public var float: Float {
        return Float(self)
    }
    
    /// SwifterSwift: Double.
    public var double: Double {
        return Double(self)
    }
    
}


// MARK: - Methods
extension CGFloat {
    
    /// SwifterSwift: Random CGFloat between two CGFloat values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random CGFloat between two CGFloat values.
    public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
        let delta = max - min
        return min + CGFloat(arc4random_uniform(UInt32(delta)))
    }
    
}

