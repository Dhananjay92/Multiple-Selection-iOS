//
//  TopBarView.swift
//  Bella
//
//  Created on 31/03/17.
//
//

import UIKit

let kTopBarYOffset : Int = 20
let kTopBarHeight : Int = 60
let kTopBarItemWidth : Int = 60

let kTopBariPhoneXOffset : Int = 22

let appBlueColor = UIColor(hexString: "0780EE")!
let appLightBlueColor = UIColor(hexString: "0ABBEC")!

enum TopBarTitleDisplay {
    case center
    case left
    case right
}

class TopBarView: UIView, UITextFieldDelegate {
    
    @objc var leftOptionDidTapped     : ((_ barButton: UIButton) -> (Void))?
    @objc var rightOptionDidTapped    : ((_ barButton: UIButton) -> (Void))?
    
    var searchLeftIconTapped    : (() -> ())?
    var searchCancelDidTapped   : (() -> (Void))?
    var searchDidBegin          : (() -> (Void))?
    var searchDidEnd            : (() -> (Void))?

    var searchTextDidChanged    : ((_ text:String) -> (Void))?
    var searchEnterDidTapped    : ((_ text:String) -> (Void))?
    
    var titleAlignment          : TopBarTitleDisplay = .center {
        didSet {
            self.resetTitleAlignment()
        }
    }
    var lblTitle                : UILabel = UILabel()
    
    var viewLeftOption          : UIView = UIView()
    var arrLeftOptions          : [String] = []
    
    var viewRightOption         : UIView = UIView()
    var arrRightOptions         : [String] = []
    
    var viewSearchBar           : UIView = UIView()
    var txtTextInput            : CustomTextField = CustomTextField()
    
    //MARK: - Top Bar Y Offset
    
    func topbarOffsetY() -> Int {
        var topYOffSet = kTopBarYOffset
        if UIDevice.isPhoneX() {
            topYOffSet += kTopBariPhoneXOffset
        }
        return topYOffSet
    }
    
    //MARK: - Setup View
    
    convenience init() {
        var topBarHeight = kTopBarHeight + kTopBarYOffset
        if UIDevice.isPhoneX() {
            topBarHeight += kTopBariPhoneXOffset
        }
        self.init(frame: CGRect(x: 0, y: 0, width: Int(SF.screenWidth), height: topBarHeight))
        self.backgroundColor = appBlueColor
    }
    
    convenience init(title : String) {
        self.init(title: title)
    }
    
    @objc convenience init(title : String, leftOptionImages : [String] = [], rightOptionImages : [String] = [], showGradiantLayer: Bool = true) {
        self.init()
        
        self.title = title
        let topYOffSet = self.topbarOffsetY()
        
        viewLeftOption.backgroundColor = UIColor.clear
        self.viewLeftOption.frame = CGRect(x:0, y:topYOffSet, width:0, height:Int(self.height - CGFloat(topYOffSet)))
        self.addSubview(viewLeftOption)
        self.setLeftOptions(leftOptionImages)
        
        viewRightOption.backgroundColor = UIColor.clear
        self.viewRightOption.frame = CGRect(x:SF.screenWidth, y:CGFloat(topYOffSet), width:0, height:self.height - CGFloat(topYOffSet))
        self.addSubview(viewRightOption)
        self.setRightOptions(rightOptionImages)
        
        lblTitle.backgroundColor = UIColor.clear
        lblTitle.numberOfLines = 2
        lblTitle.textColor = .white
        lblTitle.text  = self.title
        lblTitle.minimumScaleFactor = 0.5
        //lblTitle.adjustsFontSizeToFitWidth = true
        //lblTitle.font = UIFont(name: fontNameFromType(fontType: "bubblegum"), size: 32)
        self.addSubview(lblTitle)
        self.resetTitleAlignment()
        
        self.setupSearchBarView()
        self.viewSearchBar.isHidden = true
        
        self.setNotificatioinCount()
        
        // Set Gradiant Layers
        if showGradiantLayer == true {
            self.layer.insertSublayer(self.getGradientLayer(self.bounds), at: 0)
        }
        self.viewSearchBar.layer.insertSublayer(self.getGradientLayer(self.viewSearchBar.bounds), at: 0)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    //MARK: - Setup Search Bar View.
    
    func setupSearchBarView(placeholderText : String = "Search", leftIcon : String = "white_search_icon", rightIcon : String = "white_close_icon") -> Void {
        
        // First Remove All SubView If Already Added.
        self.viewSearchBar.subviews.forEachEnumerated { (idx, view) in
            view.removeFromSuperview()
        }
        
        // Top Bar OffSet
        let topYOffSet = self.topbarOffsetY()
        
        // Add Search View
        //viewSearchBar.backgroundColor = K.Color.appBlueColor
        viewSearchBar.frame = CGRect(x:0, y:0, width:self.width, height:self.height)
        self.addSubview(viewSearchBar)
        
        // Add Search Left Icon
        let btnSearchLeftIcon = UIButton(frame: CGRect(x: CGFloat(8.0), y: CGFloat(topYOffSet), width: CGFloat(kTopBarItemWidth), height: self.height - CGFloat(topYOffSet)))
        btnSearchLeftIcon.contentHorizontalAlignment = .center
        if (UIImage(named: "\(leftIcon)_selected")) != nil {
            btnSearchLeftIcon.setImage(UIImage(named: "\(leftIcon)_selected"), for: .selected)
        }
        btnSearchLeftIcon.setImage(UIImage(named: leftIcon), for: .normal)
        btnSearchLeftIcon.isSelected = false
        btnSearchLeftIcon.tintColor = .white
        btnSearchLeftIcon.backgroundColor = UIColor.clear
        btnSearchLeftIcon.addTarget(self, action: #selector(self.btnLeftSearchIconTapped(_:)), for: .touchUpInside)
        btnSearchLeftIcon.autoresizingMask = [.flexibleRightMargin]
        viewSearchBar.addSubview(btnSearchLeftIcon)
        
        // Add Search Text Field
        let inputX = btnSearchLeftIcon.right + 5
        let inputWidth = self.width - (inputX * 2)
        self.txtTextInput.frame = CGRect(x: inputX, y: CGFloat(topYOffSet + 5), width:inputWidth, height: self.height - CGFloat(topYOffSet + 10))
        self.txtTextInput.textColor = .white
        self.txtTextInput.tintColor = .white
        //self.txtTextInput.placeholder = placeholderText
        self.txtTextInput.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txtTextInput.font = UIFont.systemFont(ofSize: 15)
        self.txtTextInput.showBottomLine = true
        self.txtTextInput.lineColor = .white
        self.txtTextInput.returnKeyType = .search
        self.txtTextInput.backgroundColor = .clear
        self.txtTextInput.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.txtTextInput.delegate = self

        viewSearchBar.addSubview(self.txtTextInput)
        
        // Add Search Right Icon
        let btnCloseRightIcon = UIButton(frame: CGRect(x: self.txtTextInput.right + 5, y: CGFloat(topYOffSet), width: CGFloat(kTopBarItemWidth), height: self.height - CGFloat(topYOffSet)))
        btnCloseRightIcon.contentHorizontalAlignment = .center
        if (UIImage(named: "\(rightIcon)_selected")) != nil {
            btnCloseRightIcon.setImage(UIImage(named: "\(rightIcon)_selected"), for: .selected)
        }
        btnCloseRightIcon.setImage(UIImage(named: rightIcon), for: .normal)
        btnCloseRightIcon.isSelected = false
        btnCloseRightIcon.backgroundColor = UIColor.clear
        btnCloseRightIcon.addTarget(self, action: #selector(self.btnRightSearchIconTapped(_:)), for: .touchUpInside)
        btnCloseRightIcon.autoresizingMask = [.flexibleLeftMargin]
        viewSearchBar.addSubview(btnCloseRightIcon)
        
        // Bring Search Bar To Front.
        self.bringSubviewToFront(viewSearchBar)
    }
    
    var showSearchBar : Bool = false {
        didSet {
            UIView.transition(with: self.viewSearchBar, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.viewSearchBar.isHidden = !self.showSearchBar
            }, completion: { (success) in
                if self.showSearchBar == true {
                    self.txtTextInput.becomeFirstResponder()
                }
                else {
                    self.txtTextInput.resignFirstResponder()
                }
            })
        }
    }
    
    //MARK: - UITextField Delegate Actions
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        searchDidBegin?()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        searchDidEnd?()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Call Changed Block
        if searchTextDidChanged != nil {
            let searchText = NSString(format: textField.text! as NSString).replacingCharacters(in: range, with: string)
            searchTextDidChanged!(searchText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Call Enter Block
        textField.resignFirstResponder()
        if searchEnterDidTapped != nil {
            let searchText = textField.text ?? ""
            searchEnterDidTapped?(searchText)
        }
        return true
    }
    
    //MARK: - Set Search Left Right Action
    
    @objc func btnLeftSearchIconTapped(_ sender: UIButton) -> Void {
        if searchLeftIconTapped != nil {
            searchLeftIconTapped!()
        }
    }
    
    @objc func btnRightSearchIconTapped(_ sender: UIButton) -> Void {
        // Hide Search Bar
        self.showSearchBar = false
        self.txtTextInput.text = ""
        
        // Call Cancel Block
        if searchCancelDidTapped != nil {
            searchCancelDidTapped!()
        }
    }
    
    //MARK: - Set Title

    var title : String = "" {
        didSet {
            lblTitle.text = title
        }
    }
    
    //MARK: - Set Left Button
    
    func setLeftOptions(_ arrImages : [String]) -> Void {
        self.arrLeftOptions = arrImages
        
        // First remove All View From Topbar Left Option.
        self.viewLeftOption.subviews.forEachEnumerated { (idx, view) in
            view.removeFromSuperview()
        }
        
        var optionX : CGFloat = 0.0
        self.arrLeftOptions.forEachEnumerated { (idx, imageName) in
            let btnLeftOption = UIButton(frame: CGRect(x: optionX, y: CGFloat(0.0), width: CGFloat(kTopBarItemWidth), height: self.viewLeftOption.height))
            btnLeftOption.contentHorizontalAlignment = .center
            if (UIImage(named: "\(imageName)_selected")) != nil {
                btnLeftOption.setImage(UIImage(named: "\(imageName)_selected"), for: .selected)
            }
            btnLeftOption.setImage(UIImage(named: imageName), for: .normal)
            btnLeftOption.isSelected = false
            btnLeftOption.backgroundColor = UIColor.clear
            btnLeftOption.tintColor = UIColor.black
            btnLeftOption.addTarget(self, action: #selector(self.btnLeftOptionTapped(_:)), for: .touchUpInside)
            btnLeftOption.tag = idx
            self.viewLeftOption.addSubview(btnLeftOption)
            
            // Set Next Button Offset
            optionX = btnLeftOption.right
        }
        
        // Set Left View Frame
        let rightViewX = CGFloat(0.0)
        self.viewLeftOption.frame = CGRect(x:rightViewX, y:self.viewLeftOption.y, width:optionX, height:self.viewLeftOption.height)
        
        // Set Title Alignment
        self.resetTitleAlignment()
        
    }
    
    //MARK: - Set Right Button
    
    func setRightOptions(_ arrImages : [String]) -> Void {
        self.arrRightOptions = arrImages
        
        // First remove All View From Topbar Right Option.
        self.viewRightOption.subviews.forEachEnumerated { (idx, view) in
            view.removeFromSuperview()
        }
        
        var optionX : CGFloat = 0.0
        self.arrRightOptions.forEachEnumerated { (idx, imageName) in
            let btnRightOption = UIButton(frame: CGRect(x: optionX, y: CGFloat(0.0), width: CGFloat(kTopBarItemWidth), height: self.viewRightOption.height))
            btnRightOption.contentHorizontalAlignment = .center
            if let selectedImage = UIImage(named: "\(imageName)_selected") {
                btnRightOption.setImage(selectedImage, for: .selected)
            }
            btnRightOption.setImage(UIImage(named: imageName), for: .normal)
            btnRightOption.tintColor = .white
            btnRightOption.isSelected = false
            btnRightOption.backgroundColor = UIColor.clear
            btnRightOption.addTarget(self, action: #selector(self.btnRightOptionTapped(_:)), for: .touchUpInside)
            btnRightOption.tag = idx
            self.viewRightOption.addSubview(btnRightOption)
            
            // Set Next Button Offset
            optionX = btnRightOption.right
        }
        
        // Set Left View Frame
        let rightViewX = SF.screenWidth - optionX
        self.viewRightOption.frame = CGRect(x:rightViewX, y:self.viewRightOption.y, width:optionX, height:self.viewRightOption.height)
        
        // Set Title Alignment
        self.resetTitleAlignment()
        
    }
    
    @objc func btnLeftOptionTapped(_ sender: UIButton) -> Void {
        if leftOptionDidTapped != nil {
            leftOptionDidTapped!(sender)
        }
    }
    
    @objc func btnRightOptionTapped(_ sender: UIButton) -> Void {
        if rightOptionDidTapped != nil {
            rightOptionDidTapped!(sender)
        }
    }
    
    //MARK: - Reset Title Alignment
    
    func resetTitleAlignment() -> Void {
        let titleOffset : CGFloat = 8
        let topYOffSet = self.topbarOffsetY()
        
        // Left Display
        if self.titleAlignment == .left {
            let titleWidth = viewRightOption.x - viewLeftOption.right
            var titleX  : CGFloat = 12.0
            if arrLeftOptions.count > 0 {
                titleX = viewLeftOption.right
                lblTitle.font = UIFont.systemFont(ofSize: 15)
            }
            else {
                lblTitle.font = UIFont.systemFont(ofSize: 15)
            }
            
            lblTitle.frame = CGRect(x: titleX + titleOffset, y: CGFloat(topYOffSet), width: titleWidth - (titleOffset * CGFloat(2.0)), height: self.height - CGFloat(topYOffSet))
            lblTitle.textAlignment = .left
        }
        // Right Display
        else if self.titleAlignment == .right {
            let titleWidth = viewRightOption.x - viewLeftOption.right
            lblTitle.frame = CGRect(x: viewLeftOption.right + titleOffset, y: CGFloat(topYOffSet), width: titleWidth - (titleOffset * CGFloat(2.0)), height: self.height - CGFloat(topYOffSet))
            lblTitle.textAlignment = .right
        }
        // Center Display
        else {
            let maxOptionWidth = (viewRightOption.width > viewLeftOption.width) ? viewRightOption.width : viewLeftOption.width
            let titleWidth = SF.screenWidth - (maxOptionWidth * CGFloat(2.0))
            lblTitle.frame = CGRect(x: maxOptionWidth + titleOffset, y: CGFloat(topYOffSet), width: titleWidth - (titleOffset * CGFloat(2.0)), height: self.height - CGFloat(topYOffSet))
            lblTitle.textAlignment = .center
            lblTitle.centerX = SF.screenWidth/2
        }
    }
    
    //MARK: - Notification Counter
    
    func setNotificatioinCount() -> Void {
        /*if AppUtility.shared.notificationCount > 0 {
            self.btnNotification.isSelected = true
            if AppUtility.shared.notificationCount > 9 {
                self.lblNotificationCount.text = "9+"
            }else {
                self.lblNotificationCount.text = "\(AppUtility.shared.notificationCount)"
            }
            
        }else {
            self.lblNotificationCount.text = ""
            self.btnNotification.isSelected = false
        }*/
    }
    
    //MARK: - Set Gradient Layer
    
    func getGradientLayer(_ bounds: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [appBlueColor.cgColor, appLightBlueColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y:0.5)
        gradient.endPoint = CGPoint(x: 1.0, y:0.5)
        return gradient
    }
}
