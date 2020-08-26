//
//  ViewController.swift
//  Multiple-Selection
//
//  Created by Bharat Jadav on 26/08/20.
//  Copyright © 2020 Bharat Jadav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblMonthname : UILabel!
    
    // MARK: - Variables
    var topbarView  : TopBarView!
    
    var strSelectedDays     : String = ""
    var arrMonth            : [MonthsList] = []
    var selectedMonth       : [MonthsList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setMonthArray()
        self.setTopBarNaviagtion()
    }
    
    // MARK: - Set Top Bar
    private func setTopBarNaviagtion() -> Void {
        topbarView = TopBarView(title: "Multiple Selection", leftOptionImages: [], rightOptionImages: [], showGradiantLayer: true)
        topbarView.titleAlignment = .center
        topbarView.lblTitle.textColor = .white
        topbarView.leftOptionDidTapped = { (barItem: UIButton) -> Void in
            self.navigationController?.popViewController()
        }
        topbarView.rightOptionDidTapped = { (barItem: UIButton) -> Void in
            
        }
        self.view.addSubview(topbarView)
    }
    
    @IBAction func setupMultipleSelection() {
        
        let multipleSelectionVC = MultipleSelectionViewController(nibName: "MultipleSelectionViewController", bundle: nil)
        multipleSelectionVC.selectOption = 1
        //let categoryList = self.categoryData?.filter({$0.isSubscribed == true || $0.type == 1})
        multipleSelectionVC.arrMonths = self.arrMonth
        multipleSelectionVC.allowMultipleSelection = true
        //multipleSelectionVC.strSelectedIds = selectedIds
        multipleSelectionVC.returnValueType = .ids
        multipleSelectionVC.strErrorMessage = "Please select Month"
        
        multipleSelectionVC.selectionDoneTapped = { (selectedIds) in
            self.selectedMonth = (multipleSelectionVC.arrMonths?.filter({$0.isSelected}))!
            self.arrMonth = multipleSelectionVC.arrMonths ?? []
            //self.lblMonthname.text =
            self.lblMonthname.text = self.selectedMonth.compactMap({String($0.name ?? "")}).joined(separator: ", ")
        }
        
        multipleSelectionVC.modalPresentationStyle = .fullScreen
        //AppUtility.shared.navigationController?.present(multipleSelectionVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(multipleSelectionVC, animated: true)
    }
}

extension ViewController {
    // MARK: - Selected Days of Week
    func setMonthArray() {
        //let arrTemp : Array = self.strSelectedDays.components(separatedBy: ", ")
        arrMonth.removeAll()
        
        for i in 1...12 {
            switch (i) {
                case 1:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "January"
                    month?.id   = "1"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 2:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "February"
                    month?.id   = "2"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 3:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "March"
                    month?.id   = "3"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 4:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "April"
                    month?.id   = "4"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 5:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "May"
                    month?.id   = "5"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 6:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "June"
                    month?.id   = "6"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 7:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "July"
                    month?.id   = "7"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 8:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "August"
                    month?.id   = "8"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 9:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "September"
                    month?.id   = "9"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 10:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "Octomber"
                    month?.id   = "10"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 11:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "November"
                    month?.id   = "11"
                    month?.isSelected = false
                    arrMonth.append(month!)
                case 12:
                    let month = MonthsList.init(dictionary: [:])
                    month?.name = "December"
                    month?.id   = "12"
                    month?.isSelected = false
                    arrMonth.append(month!)
                default:
                    print("\(i)")
            }
        }
    }
}

