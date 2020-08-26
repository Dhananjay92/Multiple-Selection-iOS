//
//  UITextFieldExtensions.swift
//  EZSwiftExtensions
//
//  Created by Wang Yu on 6/26/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UITextField {
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
    }

    /// EZSE: Add left padding to the text in textfield
    public func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }

    /// EZSE: Add a image icon on the left side of the textfield
    public func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, w: imageSize.width, h: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /*var placeholder : String {
        set {
            super.placeholder = newValue
        }
        get {
            return super.placeholder
        }
    }*/
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    @IBInspectable var placeholderColor : UIColor  {
        get {
            return self.value(forKeyPath: "_placeholderLabel.textColor") as! UIColor
            //return self.attributedPlaceholder?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil)  as! UIColor
        }
        set {
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
            /*self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
                                                                   attributes:[NSForegroundColorAttributeName: newValue])*/
        }
    }
    
    /// SwifterSwift: Check if text field is empty.
    public var isEmpty: Bool {
        return text?.isEmpty == true
    }
    
    /// SwifterSwift: Return text with no spaces or new lines in beginning and end.
    public var trimmedText: String? {
        return text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Clear text.
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
}

var INZMaxLengthKey         = "INZMaxLengthKey"
var INZAllowCharacterKey    = "INZAllowCharacterKey"
var INZDisAllowCharacterKey = "INZDisAllowCharacterKey"


extension UITextField {
    
    func addTextChangeTarget() {
        self.removeTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
        self.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
    }
    
    @objc func textFieldTextChanged(textField : UITextField) -> Void {
        if  allowCharacter != nil {
            let allowCharSet = NSCharacterSet(charactersIn: allowCharacter!) as CharacterSet
            let disAllowCharSet = NSCharacterSet(charactersIn: allowCharacter!).inverted as CharacterSet
            if self.text?.lastCharacter?.rangeOfCharacter(from: allowCharSet) == nil {
                textField.text = textField.text?.trimmingCharacters(in: disAllowCharSet)
            }
            
        }else if disAllowCharacter != nil {
            let disAllowCharSet = CharacterSet(charactersIn: disAllowCharacter!)
            if self.text?.lastCharacter?.rangeOfCharacter(from: disAllowCharSet) != nil {
                textField.text = textField.text?.trimmingCharacters(in: disAllowCharSet)
            }
        }
        let adaptedLength = min((self.text?.length)!, self.maxLength)
        let index = self.text?.index((self.text?.startIndex)!, offsetBy: adaptedLength)
        //self.text =  self.text?.substring(to: index!)
        let str = self.text ?? ""
        self.text = String(str[..<index!])
    }
    
//    func lastCharacter() -> String {
//        if let str = self.text {
//            return String(describing: str.last)
//        }
//        return ""
//    }
//    
    @IBInspectable var allowCharacter : String?  {
        get {
            return objc_getAssociatedObject(self, &INZAllowCharacterKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &INZAllowCharacterKey, (newValue?.lowercased())!+(newValue?.uppercased())!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeTarget()
        }
    }
    
    @IBInspectable var disAllowCharacter : String?  {
        get {
            return objc_getAssociatedObject(self, &INZDisAllowCharacterKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &INZDisAllowCharacterKey, (newValue?.lowercased())!+(newValue?.uppercased())!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeTarget()
        }
    }
    
    @IBInspectable var maxLength : Int  {
        get {
            return objc_getAssociatedObject(self, &INZMaxLengthKey) as? Int ?? Int(INT_MAX)
        }
        set {
            objc_setAssociatedObject(self, &INZMaxLengthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTextChangeTarget()
        }
    }
}

