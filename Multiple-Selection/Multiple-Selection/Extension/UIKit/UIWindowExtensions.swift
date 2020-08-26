//
//  UIWindowExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 3/1/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UIWindow {
    /// EZSE: Creates and shows UIWindow. The size will show iPhone4 size until you add launch images with proper sizes. TODO: Add to readme
    public convenience init(viewController: UIViewController, backgroundColor: UIColor) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = viewController
        self.backgroundColor = backgroundColor
        self.makeKeyAndVisible()
    }
    
    class func getVisibleViewController(from vc: UIViewController?) -> UIViewController? {
        if (vc is UINavigationController) {
            return UIWindow.getVisibleViewController(from: (vc as? UINavigationController)?.visibleViewController)
        } else if (vc is UITabBarController) {
            return UIWindow.getVisibleViewController(from: (vc as? UITabBarController)?.selectedViewController)
        } else {
            if vc?.presentedViewController != nil {
                return UIWindow.getVisibleViewController(from: vc?.presentedViewController)
            } else {
                return vc
            }
        }
    }
    
    @objc var visibleViewController: UIViewController? {
        let rootViewController: UIViewController? = self.rootViewController
        return UIWindow.getVisibleViewController(from: rootViewController)
    }
    
    class func getPresentView(from vc: UIViewController?, withKeyView keyView: UIView?) -> UIView? {
        if (vc is UINavigationController) {
            return getPresentView(from: (vc as? UINavigationController)?.visibleViewController, withKeyView: keyView)
        } else if (vc is UITabBarController) {
            return getPresentView(from: (vc as? UITabBarController)?.selectedViewController, withKeyView: keyView)
        } else {
            if vc?.presentedViewController != nil {
                let presentedView: UIView? = vc?.presentedViewController?.view
                return getPresentView(from: vc?.presentedViewController, withKeyView: presentedView)
            }
            else if vc?.tabBarController == nil {
                return vc?.view
            }
            else {
                return keyView
            }
        }
    }
    
    @objc func viewForPresentController(keyView: UIView) -> UIView? {
        let rootViewController: UIViewController? = self.rootViewController
        return UIWindow.getPresentView(from: rootViewController, withKeyView: keyView)
    }
}
