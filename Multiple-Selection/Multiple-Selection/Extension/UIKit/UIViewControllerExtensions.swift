//
//  UIViewControllerExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }
    
    /// SwifterSwift: NavigationBar in a ViewController.
    public var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    // MARK: - Notifications
    //TODO: Document this part
    public func addNotificationObserver(_ name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }

    public func removeNotificationObserver(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }

    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    #if os(iOS)

    @objc public func keyboardDidShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let frame = value.cgRectValue
            keyboardDidShowWithFrame(frame)
        }
    }

    @objc public func keyboardWillShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let frame = value.cgRectValue
            keyboardWillShowWithFrame(frame)
        }
    }

    @objc public func keyboardWillHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let frame = value.cgRectValue
            keyboardWillHideWithFrame(frame)
        }
    }

    @objc public func keyboardDidHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let frame = value.cgRectValue
            keyboardDidHideWithFrame(frame)
        }
    }

    public func keyboardWillShowWithFrame(_ frame: CGRect) {

    }

    public func keyboardDidShowWithFrame(_ frame: CGRect) {

    }

    public func keyboardWillHideWithFrame(_ frame: CGRect) {

    }

    public func keyboardDidHideWithFrame(_ frame: CGRect) {

    }

    //EZSE: Makes the UIViewController register tap events and hides keyboard when clicked somewhere in the ViewController.
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    public func hideKeyboardWhenSwipeDown() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }

    public func hideKeyboardWhenTappedAroundAndCancelsTouchesInView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    #endif

    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - VC Container

    /// EZSwiftExtensions
    public var top: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.top
            }
            if let nav = self.navigationController {
                if nav.isNavigationBarHidden {
                    return view.top
                } else {
                    return nav.navigationBar.bottom
                }
            } else {
                return view.top
            }
        }
    }

    /// EZSwiftExtensions
    public var bottom: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.bottom
            }
            if let tab = tabBarController {
                if tab.tabBar.isHidden {
                    return view.bottom
                } else {
                    return tab.tabBar.top
                }
            } else {
                return view.bottom
            }
        }
    }

    /// EZSwiftExtensions
    public var tabBarHeight: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.tabBarHeight
            }
            if let tab = self.tabBarController {
                return tab.tabBar.frame.size.height
            }
            return 0
        }
    }

    /// EZSwiftExtensions
    public var navigationBarHeight: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarHeight
            }
            if let nav = self.navigationController {
                return nav.navigationBar.height
            }
            return 0
        }
    }

    /// EZSwiftExtensions
    public var navigationBarColor: UIColor? {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarColor
            }
            return navigationController?.navigationBar.tintColor
        } set(value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }

    /// EZSwiftExtensions
    public var navBar: UINavigationBar? {
        get {
            return navigationController?.navigationBar
        }
    }

    /// EZSwiftExtensions
    public var applicationFrame: CGRect {
        get {
            return CGRect(x: view.x, y: top, width: view.width, height: bottom - top)
        }
    }

    // MARK: - VC Flow

    /// EZSwiftExtensions
    public func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

    /// EZSwiftExtensions
    public func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }

    /// EZSwiftExtensions
    public func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }

    /// EZSwiftExtensions
    public func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }

    /// EZSwiftExtensions
    public func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        self.addChild(vc)
        toView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }

    ///EZSE: Adds image named: as a UIImageView in the Background
    func setBackgroundImage(_ named: String) {
        let image = UIImage(named: named)
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }

    ///EZSE: Adds UIImage as a UIImasendSubviewToBackhound
    @nonobjc func setBackgroundImage(_ image: UIImage) {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    
}
