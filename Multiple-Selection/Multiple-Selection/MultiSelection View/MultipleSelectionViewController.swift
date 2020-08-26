//
//  MultipleSelectionViewController.swift
//  Bella
//
//  Created by seema.p on 27/07/17.
//
//

import UIKit

enum ShowInfo {
    case showInfoTitleOnly
    case showInfoImageOnly
    case showInfoBoth
}

enum SelectionReturnType {
    case name
    case ids
}

public class MonthsList : NSObject {
    public var name : String?
    public var id   : String?
    public var isSelected : Bool = false
    
    required public init?(dictionary: NSDictionary) {
        name = dictionary["name"] as? String ?? ""
        id   = dictionary["id"] as? String ?? ""
        isSelected = dictionary["isSelected"] as? Bool ?? false
    }
}


class MultipleSelectionCell: UITableViewCell {
    
    @IBOutlet var imgUser : UIImageView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var imageViewAccessory : UIImageView!
    
    var markSelected : Bool = false {
        didSet {
            self.imageViewAccessory.isHighlighted = markSelected
        }
    }
    
    var isShowInfo : ShowInfo = .showInfoTitleOnly {
        didSet {
            
            self.lblTitle.isHidden = false;
            self.imgUser.isHidden = false;
            
            switch isShowInfo {
            case .showInfoImageOnly:
                self.lblTitle.isHidden = true;
                break
            case .showInfoTitleOnly:
                self.imgUser.isHidden = true;
                self.lblTitle.width = self.width - (self.imageViewAccessory.width + 10 + 16);
                self.lblTitle.x = 10;
                break
            default:
                self.lblTitle.width = self.width - (self.imageViewAccessory.width + 16 + self.imgUser.right + 8);
                self.lblTitle.x = self.imgUser.right + 8;
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.imgUser.setCornerRadius(radius: self.imgUser.width/2)
    }
    
}

class MultipleSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet var tblMultipleSelection: UITableView!
    @IBOutlet var headerView : UIView!
    @IBOutlet var lblHeaderTitle : UILabel!
    
    var otherSelected : Bool! = false
    
    var topbarView: TopBarView!
    
    var showInfo : ShowInfo! = .showInfoTitleOnly
    var returnValueType : SelectionReturnType! = .ids
        
    var strSelectedIds: String! = ""
    var allowMultipleSelection: Bool = true
    
    var strTitleText: String! = ""
    var strErrorMessage: String! = ""
    var strCategoryName: String! = ""
    
    var selectionCancelTapped : (() -> (Void))?
    var selectionDoneTapped : ((_ selectedIds: String) -> (Void))?
    
    //var categoryList : [HomeModel]?
    //var videoList    : [categoryVideo]?
    var arrMonths    : [MonthsList]?
    var selectOption : Int = 0
    var isAllSelected : Bool = false
    var selectedYear : Int = 0
    var isCategorySubscribed : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTopBarNaviagtion()
        self.setSelectedObjects()
        
        // Load Attachment Cell
        let multipleSelectionCell : UINib = UINib(nibName: "MultipleSelectionCell", bundle: nil)
        self.tblMultipleSelection.register(multipleSelectionCell, forCellReuseIdentifier: "MultipleSelectionCell")
        
        // Reset Table View Height.
        self.tblMultipleSelection.height = self.view.height - topbarView.height
        self.tblMultipleSelection.y = topbarView.height
        
        if selectOption == 1 {
            self.tblMultipleSelection.tableHeaderView = nil
        }
        else if selectOption == 2 {
            if isCategorySubscribed == 1 {
                self.tblMultipleSelection.tableHeaderView = headerView
            }
            else {
                self.tblMultipleSelection.tableHeaderView = nil
            }
        }
        else {
            if selectedYear == Date().year {
                self.tblMultipleSelection.tableHeaderView = nil
            }
            else {
                self.tblMultipleSelection.tableHeaderView = headerView
            }
        }
        self.headerView.addTapGesture { (gesture) in
            self.isAllSelected = true
            self.lblHeaderTitle.text = "Unselect All"
            self.arrMonths?.forEachEnumerated({ (idx, option) in
                option.isSelected = true
            })
            
            self.tblMultipleSelection.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: - Add Navigation Bar
    
    func setTopBarNaviagtion() -> Void {
        topbarView = TopBarView(title: "Selection Option", leftOptionImages: ["ic_back"], rightOptionImages: ["ic_tick_orange"], showGradiantLayer: true)
        topbarView.titleAlignment = .left
        topbarView.lblTitle.textColor = .white
        
        topbarView.leftOptionDidTapped = { (barItem: UIButton) -> Void in
            if !self.otherSelected {
                self.actionCancelTapped(barItem)
            }
        }
        
        topbarView.rightOptionDidTapped = { (barItem: UIButton) -> Void in
            if !self.otherSelected {
                self.actionDoneTapped(barItem)
            }
        }
        
        self.view.addSubview(topbarView)
    }
    
    //MARK: - Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Set Selected Objects
    func setSelectedObjects() -> Void {
        // Only allow single selection.
        if self.allowMultipleSelection == false {
            self.arrMonths?.forEachEnumerated({ (idx, option) in
                //option.isSelected = false
            })
        }
        else {
            self.arrMonths?.forEachEnumerated({ (idx, option) in
                //option.isSelected = false
            })
        }
        
        // Set Selected Objects
        /*
        let arrIds = self.strSelectedIds.components(separatedBy: ",")
        if selectOption == 1 {
            self.arrMonths?.forEachEnumerated { (idx, option) in
                var matchValue = "\(option.id ?? "")"
                if self.returnValueType == SelectionReturnType.name {
                    matchValue = "\(option.name!)"
                }
                
                if arrIds.contains(matchValue) {
                    option.isSelected = true
                }
                else {
                    option.isSelected = false
                }
            }
        } */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMonths!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleSelectionCell", for: indexPath) as! MultipleSelectionCell
        
        // Set Data
        let option = self.arrMonths?[indexPath.row]
        cell.lblTitle.text = option?.name
        cell.markSelected = option?.isSelected ?? false
        cell.isShowInfo = self.showInfo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Only allow single selection.
        if self.allowMultipleSelection == false {
            self.arrMonths?.forEachEnumerated({ (idx, option) in
                option.isSelected = false
            })
        }
        
        let option = self.arrMonths?[indexPath.row]
        option?.isSelected = !(option?.isSelected ?? false)
        
        self.tblMultipleSelection.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
    //MARK: - Other Option Methods
    
    func dismissOtherOption() {
        self.view.endEditing(true)
        self.tblMultipleSelection.reloadData()
        self.otherSelected = false
    }
    
    @IBAction func cancelTapped(_ sender : UIButton) {
        self.dismissOtherOption()
    }
    
    //MARK: - Action Methods
    func actionCancelTapped(_ sender:UIButton) -> Void {
        if selectionCancelTapped != nil {
            selectionCancelTapped!()
        }
        
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController()
    }
    
    func actionDoneTapped(_ sender:UIButton) -> Void {
        self.view.endEditing(true)
        var arrSelectedIds: Array<String> = []
        //var selectedIndex : Int = -1
        if selectOption == 1 {
            self.arrMonths?.forEachEnumerated { (idx, option) in
                if option.isSelected == true {
                    if self.returnValueType == SelectionReturnType.ids {
                        arrSelectedIds.append("\(String(describing: option.id))")
                    }
                }
            }
            if arrSelectedIds.count <= 0 {
                //ISMessages.show(self.strErrorMessage, type: .info)
                return
            }
            
            if selectionDoneTapped != nil {
                self.strSelectedIds = arrSelectedIds.joined(separator: ",")
                selectionDoneTapped!(self.strSelectedIds)
            }
        }
        
        self.dismissOtherOption()
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController()
    }
}
