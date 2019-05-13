//
//  String+Extension.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 13/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

extension String{
    var localized:String {
        return NSLocalizedString(self, tableName: "Main", bundle: .main, value: "\(self)", comment: "")
    }
}
