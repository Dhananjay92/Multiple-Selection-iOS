//
//  UNUserNotificationCenter.swift
//  PhyzMe
//
//  Created by Bharat Jadav on 21/06/20.
//  Copyright © 2020 Bharat Jadav. All rights reserved.
//

import UIKit

extension UNUserNotificationCenter{
    func cleanRepeatingNotifications(){
        //cleans notification with a userinfo key endDate
        //which have expired.
        var cleanStatus = "Cleaning...."
        getPendingNotificationRequests {
            (requests) in
            for request in requests{
                if let endDate = request.content.userInfo["endDate"] {
                    if Date() >= (endDate as! Date) {
                        print("repeating notification identifier: \(request.identifier)")
                    }
                    else {
                        cleanStatus += "No Cleaning"
                    }
                    print(cleanStatus)
                }
            }
        }
    }
}

