//
//  BoolExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 16/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

extension Bool {
    /// EZSE: Converts Bool to Int.
    public var toInt: Int { return self ? 1 : 0 }

    /// EZSE: Toggle boolean value.
    @discardableResult
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }
}

// MARK: - Properties
extension Bool {
    
    /// SwifterSwift: Return 1 if true, or 0 if false.
    public var int: Int {
        return self ? 1 : 0
    }
    
    /// SwifterSwift: Return "true" if true, or "false" if false.
    public var string: String {
        return description
    }
    
    /// SwifterSwift: Return inversed value of bool.
    public var toggled: Bool {
        return !self
    }
}

