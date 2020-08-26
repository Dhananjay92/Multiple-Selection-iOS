//
//  CGPointExtensions.swift
//  EZSwiftExtensions
//
//  Created by Sanyal, Arunav on 10/29/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension CGPoint {
    
    /// EZSE: Converts angle degrees to radians.
//    public static func + (this: CGPoint, that: CGPoint) -> CGPoint {
//        return CGPoint(x: this.x + that.x, y: this.y + that.y)
//    }
    
    /// EZSE: Calculates the distance between two CG Points. 
    /// Inspired by : http://stackoverflow.com/questions/1906511/how-to-find-the-distance-between-two-cg-points
    public static func distance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(pow(to.x - from.x, 2) + pow(to.y - from.y, 2))
    }
    
    /// EZSE: Normalizes the vector described by the CGPoint to length 1.0 and returns the result as a new CGPoint.
    public func normalized() -> CGPoint {
        let len = CGPoint.distance(from: self, to: CGPoint.zero)
        return CGPoint(x: self.x / len, y: self.y / len)
    }
    
    //// EZSE: Returns the angle represented by the point.
    public var angle: CGFloat {
        return atan2(y, x)
    }
    
    //// EZSE: Returns the dot product of two vectors represented by points
    public static func dotProduct(this: CGPoint, that: CGPoint) -> CGFloat {
        return this.x * that.x + this.y * that.y
    }
}

// MARK: - Methods
public extension CGPoint {
    
    /// SwifterSwift: Distance from another CGPoint.
    ///
    /// - Parameter point: CGPoint to get distance from.
    /// - Returns: Distance between self and given CGPoint.
    func distance(from point: CGPoint) -> CGFloat {
        return CGPoint.distance(from: self, to: point)
    }
    
    /// SwifterSwift: Distance between two CGPoints.
    ///
    /// - Parameters:
    ///   - point1: first CGPoint.
    ///   - point2: second CGPoint.
    /// - Returns: distance between the two given CGPoints.
//    public static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
//        // http://stackoverflow.com/questions/6416101/calculate-the-distance-between-two-cgpoints
//        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
//    }
    
}


// MARK: - Operators
public extension CGPoint {
    
    /// SwifterSwift: Add two CGPoints.
    ///
    /// - Parameters:
    ///   - lhs: CGPoint to add to.
    ///   - rhs: CGPoint to add.
    /// - Returns: result of addition of the two given CGPoints.
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    /// SwifterSwift: Add a CGPoints to self.
    ///
    /// - Parameters:
    ///   - lhs: self
    ///   - rhs: CGPoint to add.
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    /// SwifterSwift: Subtract two CGPoints.
    ///
    /// - Parameters:
    ///   - lhs: CGPoint to subtract from.
    ///   - rhs: CGPoint to subtract.
    /// - Returns: result of subtract of the two given CGPoints.
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    /// SwifterSwift: Subtract a CGPoints from self.
    ///
    /// - Parameters:
    ///   - lhs: self
    ///   - rhs: CGPoint to subtract.
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    /// SwifterSwift: Multiply a CGPoint with a scalar
    ///
    /// - Parameters:
    ///   - point: CGPoint to multiply.
    ///   - scalar: scalar value.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    /// SwifterSwift: Multiply self with a scalar
    ///
    /// - Parameters:
    ///   - point: self.
    ///   - scalar: scalar value.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    static func *= (point: inout CGPoint, scalar: CGFloat) {
        point = point * scalar
    }
    
    /// SwifterSwift: Multiply a CGPoint with a scalar
    ///
    /// - Parameters:
    ///   - scalar: scalar value.
    ///   - point: CGPoint to multiply.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
}
