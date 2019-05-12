//
//  CityUIMapper.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import CoreLocation

struct CityUIMapper {
    
    static func convertUImodel(cityListInfo: [CityInfoResponse]) -> (CityDictionary, [CityInfo]) {
        
        let alphabet = (0..<26).map { Character(UnicodeScalar(("A" as UnicodeScalar).value + $0)!) }
        var dict = CityDictionary(dictionaryOfCity: [Character : [CityInfo]]())
        var allCities = [CityInfo]()
        
        allCities = alphabet.flatMap { (letter) -> [CityInfo] in
            let cityList = cityListInfo.filter{$0.name.starts(with: String(letter))}
                .compactMap{ CityInfo(coord: Coordinate(lat: $0.coord.lat,
                                                        lon: $0.coord.lon),
                                      country: $0.country,
                                      name: $0.name,
                                      distanceFromCurrentLocation: nil )}
                .sorted(by: { $0.name < $1.name })
            
            dict.dictionaryOfCity[letter] = cityList
            return cityList
        }
        
        return (dict, allCities)
    }
}
