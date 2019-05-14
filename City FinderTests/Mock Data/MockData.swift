//
//  MockData.swift
//  City FinderTests
//
//  Created by Akshay Kulkarni on 13/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
@testable import City_Finder

class MockCityInfo {
    
    class func getCities() -> [CityInfo] {
        var cities = [CityInfo]()
        
        cities.append(CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "IN", name: "Pune", distanceFromCurrentLocation: nil))
        cities.append(CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "US", name: "Hurzuf", distanceFromCurrentLocation: nil))
        cities.append(CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "UAE", name: "Dubai", distanceFromCurrentLocation: nil))
        cities.append(CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "RU", name: "Novinki", distanceFromCurrentLocation: nil))
        cities.append(CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "UA", name: "Alupka", distanceFromCurrentLocation: nil))
        cities.append(CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "IN", name: "Ahmadabad", distanceFromCurrentLocation: nil))
        return cities
    }
    
}

class CityDictionaryMock {
    
    class func mockData() -> CityDictionary {
        var dict = [Character : [CityInfo]]()
        
        dict["A"] = [CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "UA", name: "Alupka", distanceFromCurrentLocation: nil),
                     CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "IN", name: "Ahmadabad", distanceFromCurrentLocation: nil)]
        
        dict["P"] = [CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "IN", name: "Pune", distanceFromCurrentLocation: nil),
                     CityInfo(coord: Coordinate(lat: 44.549999, lon: 34.283332999999999), country: "IN", name: "Patna", distanceFromCurrentLocation: nil)]
        
        return CityDictionary(dictionaryOfCity: dict)
    }
    
}

class MockCityInfoResponse {
    
    func mockData() -> [CityInfoResponse] {
        var cities = [CityInfoResponse]()
        
        cities.append(CityInfoResponse(_id: 0, coord: Coord(lat: 55.683334000000002, lon: 37.666668000000001), country: "RU", name: "Novinki"))
        cities.append(CityInfoResponse(_id: 0, coord: Coord(lat: 55.683334000000002, lon: 37.666668000000001), country: "IN", name: "Pune"))
        cities.append(CityInfoResponse(_id: 0, coord: Coord(lat: 55.683334000000002, lon: 37.666668000000001), country: "IN", name: "Mumbai"))
        cities.append(CityInfoResponse(_id: 0, coord: Coord(lat: 55.683334000000002, lon: 37.666668000000001), country: "IN", name: "Banglore"))
        cities.append(CityInfoResponse(_id: 0, coord: Coord(lat: 55.683334000000002, lon: 37.666668000000001), country: "US", name: "New york"))
        return cities
    }
    
}
