//
//  UIResponder+Additions.swift
//  Phyzyou
//
//  Created by Pradeep Kumar on 03/09/18.
//  Copyright © 2018 TechAhead. All rights reserved.
//

import UIKit

extension UIResponder {
    
    func owningViewController() -> UIViewController? {
        var nextResponser = self
        while let next = nextResponser.next {
            nextResponser = next
            if let vc = nextResponser as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
