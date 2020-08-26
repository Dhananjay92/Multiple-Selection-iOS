//
//  UITextViewExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UITextView {
    /// EZSwiftExtensions: Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
    /// textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName, fontsize = 17
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(x: x, y: y, w: w, h: h, fontSize: 17)
    }

    /// EZSwiftExtensions: Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
    /// textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, fontSize: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        font = UIFont.HelveticaNeue(type: FontType.None, size: fontSize)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        textAlignment = NSTextAlignment.left
        isUserInteractionEnabled = true

        #if os(iOS)

        isEditable = false

        #endif

        isScrollEnabled = false
    }
    
    /// SwifterSwift: Clear text.
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    /// SwifterSwift: Scroll to the bottom of text view
    public func scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }
    
    /// SwifterSwift: Scroll to the top of text view
    public func scrollToTop() {
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
}

var INZPlaceHoldetTextViewKey       = "INZPlaceHoldetTextViewKey"
var INZPlaceHoldetTextColorKey      = "INZPlaceHoldetTextColorKey"
var INZPlaceHoldetTextKey           = "INZPlaceHoldetTextKey"
var INZMaxLengthTextViewKey         = "INZMaxLengthTextViewKey"
var INZAllowCharacterTextViewKey    = "INZAllowCharacterTextViewKey"
var INZDisAllowCharacterTextViewKey = "INZDisAllowCharacterTextViewKey"

extension UITextView {
    
    func addTextChangeObserver() {
        NotificationCenter.default.removeObserver(self, name:  UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewTextChanged(notification:)), name:  UITextView.textDidChangeNotification, object: nil)
    }
    
    func placeHolderTextView() -> UITextView? {
        return objc_getAssociatedObject(self, &INZMaxLengthTextViewKey) as? UITextView
    }
    
    func setPlaceHolderTextView(textView: UITextView?) {
        if textView != nil {
            objc_setAssociatedObject(self, &INZMaxLengthTextViewKey, textView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable var disAllowCharacter : String?  {
        get {
            return objc_getAssociatedObject(self, &INZDisAllowCharacterTextViewKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &INZDisAllowCharacterTextViewKey, (newValue?.lowercased())!+(newValue?.uppercased())!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeObserver()
        }
    }
    
    @IBInspectable var allowCharacter : String?  {
        get {
            return objc_getAssociatedObject(self, &INZAllowCharacterTextViewKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &INZAllowCharacterTextViewKey, (newValue?.lowercased())!+(newValue?.uppercased())!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeObserver()
        }
    }
    
    @IBInspectable var placeHolder : String?  {
        get {
            return objc_getAssociatedObject(self, &INZPlaceHoldetTextKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &INZPlaceHoldetTextKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeObserver()
            var phTextView = placeHolderTextView()
            if phTextView == nil {
                phTextView = UITextView(frame: self.bounds)
                phTextView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                phTextView?.font = self.font
                phTextView?.textAlignment = .left
//                phTextView?.textContainerInset = .zero
//                phTextView?.textContainer.lineFragmentPadding = 0
                phTextView?.backgroundColor = UIColor.clear;
                if placeHolder == "Mission" || placeHolder == "Service" {
                    phTextView?.textContainerInset = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: 10)
                }
                phTextView?.textColor = UIColor.init(hexString: "434343", transparency: 0.75)!
                phTextView?.isUserInteractionEnabled = false;
                
                self.addSubview(phTextView!)
                setPlaceHolderTextView(textView: phTextView)
            }
            phTextView?.text = newValue;
            if self.text.length > 0 {
                phTextView?.isHidden = true
            }
        }
    }
    
    @IBInspectable var placeHolderColor : UIColor?  {
        get {
            return objc_getAssociatedObject(self, &INZPlaceHoldetTextColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &INZPlaceHoldetTextColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let textView = placeHolderTextView() {
                textView.textColor = newValue
            }
        }
    }
    
    @IBInspectable var maxLength : Int {
        get {
            return objc_getAssociatedObject(self, &INZMaxLengthTextViewKey) as? Int ?? Int(INT_MAX)
        }
        set {
            objc_setAssociatedObject(self, &INZMaxLengthTextViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeObserver()
        }
    }
    
    @objc func textViewTextChanged(notification : NSNotification) -> Void {
        let textView = notification.object as! UITextView
        placeHolderTextView()?.isHidden = self.text.length > 0 ? true : false
        if  allowCharacter != nil {
            let allowCharSet = NSCharacterSet(charactersIn: allowCharacter!) as CharacterSet
            let disAllowCharSet = NSCharacterSet(charactersIn: allowCharacter!).inverted as CharacterSet
            if lastCharacter().rangeOfCharacter(from: allowCharSet) == nil {
                textView.text = textView.text?.trimmingCharacters(in: disAllowCharSet)
            }
            
        }
        else if disAllowCharacter != nil {
            let disAllowCharSet = CharacterSet(charactersIn: disAllowCharacter!)
            if lastCharacter().rangeOfCharacter(from: disAllowCharSet) != nil {
                textView.text = textView.text?.trimmingCharacters(in: disAllowCharSet)
            }
        }
        let adaptedLength = min((self.text?.length)!, self.maxLength)
        let index = self.text?.index((self.text?.startIndex)!, offsetBy: adaptedLength)
        //self.text =  self.text?.substring(to: index!)
        let str = self.text ?? ""
        self.text = String(str[..<index!])
    }
    
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        let border = UIView()
        //border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y+self.frame.height-height, w: self.frame.width, h: height)
        border.backgroundColor = color
        self.superview!.insertSubview(border, aboveSubview: self)
    }
    
    
    func lastCharacter() -> String {
        if let str = self.text {
            return String(describing: str.last)
        }
        return ""
    }
}

