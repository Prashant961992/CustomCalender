//
//  Utility.swift
//  CalenderDemo
//
//  Created by Prashant on 10/08/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class Utility: NSObject {
    static let sharedInstance = Utility()
    
    func celldateIS(year : Int , month : Int , day : String) -> String {
        var date = String()
        var cmonth = "\(month)"
        if cmonth.count == 1{
            cmonth = "0\(month)"
        }else{
            cmonth = "\(month)"
        }
        if day.count == 1{
            date = "\(year)-\(cmonth)-0\(day)"
        }else{
            date = "\(year)-\(cmonth)-\(day)"
        }
        return date
    }
}
