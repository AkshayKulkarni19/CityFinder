//
//  CityInfoResponse.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 09/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

/* json structure
 
 {
 "_id" : 707860,
 "coord" : {
 "lat" : 44.549999,
 "lon" : 34.283332999999999
 },
 "country" : "UA",
 "name" : "Hurzuf"
 },
 
 */

import Foundation

struct CityInfoResponse: Codable {
    var _id: Int?
    var coord: Coord
    var country: String = ""
    var name: String = ""
}

struct Coord: Codable {
    var lat: Double = 0
    var lon: Double = 0
}
