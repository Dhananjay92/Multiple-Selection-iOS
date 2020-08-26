//
//  UIViewLanguageExtension.swift

//
//  Created by Henryp on 16/11/16.
//
//

import UIKit
import ObjectiveC

private struct AssociatedKeys {
    static var RightMargin = "ViewRightMargin"
    static var IsUpdateForArabic = "ViewIsUpdateForArabic"
    static var NoNeedToUpdateFrame = "ViewNoNeedToUpdateFrame"
    static var flipForArabic = "ViewflipForArabic"
    
}


extension UIView {
    
    private var isUpdateForArabic : Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.IsUpdateForArabic) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.IsUpdateForArabic, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    @IBInspectable var flipForArabic : Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.flipForArabic) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.flipForArabic, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    // set noNeedToUpdateFrame = true if this view's subview frame is  not require to update for arabic language
    
    @IBInspectable var noNeedToUpdateFrame : Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.NoNeedToUpdateFrame) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.NoNeedToUpdateFrame, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    
    @IBInspectable var rightMargin : CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.RightMargin) as? CGFloat ?? 0.0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.RightMargin, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    func updateForSelectedLangauge() {
        /*
        for subView: UIView in self.subviews {
            if subView.noNeedToUpdateFrame ==  false {
                if AppUtility.IS_ARABIC_SELECTED() {
                    if !subView.isUpdateForArabic {
                        subView.isUpdateForArabic = true
                        subView.updateFrame()
                        if (subView is FloatRatingView || subView.flipForArabic == true) {
                            subView.transform = CGAffineTransform(scaleX: 1, y: -1)
                            subView.rotate(180, secs: 0, delegate: nil, callback: nil)
                            subView.layoutSubviews()
                        }
                    }
                }
                else {
                    if subView.isUpdateForArabic {
                        subView.isUpdateForArabic = false
                        subView.updateFrame()
                        if (subView is FloatRatingView || subView.flipForArabic == true) {
                            subView.transform = CGAffineTransform.identity
                        }
                    }
                }
                
                
                if subView.isKind(of: UIView.self) && subView.noNeedToUpdateFrame ==  false {
                    subView.updateForSelectedLangauge()
                    
                }
                
                
                /* if  subView.noNeedToUpdateFrame ==  false {
                 if subView .isKind(of: UITextField.self ) == false {
                 subView.updateForSelectedLangauge()
                 }
                 }*/
            }
            else if subView.flipForArabic == true {
                if AppUtility.IS_ARABIC_SELECTED() {
                    subView.transform = CGAffineTransform(scaleX: 1, y: -1)
                    subView.rotate(180, secs: 0, delegate: nil, callback: nil)
                    subView.layoutSubviews()
                    
                }
                else {
                    
                    subView.transform = CGAffineTransform.identity
                    
                }
            }
        }
 */
    }
    
    func transformScaleForSelectedLanguage() {
        /*
        var trasform = CGAffineTransform.identity
        if AppUtility.IS_ARABIC_SELECTED() {
            trasform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        self.transform = trasform
 */
    }
    
    
    private func updateFrame() {
        self.x = self.superview!.width - self.width - self.x - self.rightMargin
        if (self is UILabel) {
            let lbl = (self as! UILabel)
            if lbl.textAlignment == .left {
                lbl.textAlignment = .right
            }
            else if lbl.textAlignment == .right {
                lbl.textAlignment = .left
            }
        }
        if (self is UITextField) {
            let txtField = (self as! UITextField)
            if txtField.textAlignment == .left {
                txtField.textAlignment = .right
            }
            else if txtField.textAlignment == .right {
                txtField.textAlignment = .left
            }
        }
        if (self is UITextView) {
            let txtView = (self as! UITextView)
            if txtView.textAlignment == .left {
                txtView.textAlignment = .right
            }
            else if txtView.textAlignment == .right {
                txtView.textAlignment = .left
            }
        }
        if (self is UIButton) {
            let btn = (self as! UIButton)
            if btn.contentHorizontalAlignment == .left {
                btn.contentHorizontalAlignment = .right
            }
            else if btn.contentHorizontalAlignment == .right {
                btn.contentHorizontalAlignment = .left
            }
        }
        if (self is UISearchBar) {
            let searchBar = (self as! UISearchBar)
            print(searchBar)
        }
    }
    
    
    
    
    
}
