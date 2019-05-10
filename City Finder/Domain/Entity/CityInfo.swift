//
//  CityInfo.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

struct CityInfo {
    var coord: Coordinate
    var country: String
    var name: String
}

struct Coordinate {
    var lat: Double
    var lon: Double
}
