//
//  UIBarButtonItemExtensions.swift
//  EZSwiftExtensionsExample
//
//  Created by Goktug Yilmaz on 5/28/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    
    
    // MARK: - Methods
    extension UIBarButtonItem {
        
        /// SwifterSwift: Add Target to UIBarButtonItem
        ///
        /// - Parameters:
        ///   - target: target.
        ///   - action: selector to run when button is tapped.
        public func addTargetForAction(target: AnyObject, action: Selector) {
            self.target = target
            self.action = action
        }
        
        @IBInspectable var renderOriginalImage : Bool  {
            get {
                return true
            }
            set {
                if newValue == true {
                    self.image = self.image?.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        
    }
#endif
