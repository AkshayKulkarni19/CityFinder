//
//  CityUIMapper.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

struct CityUIMapper {
    
    static func convertUImodel(cityListInfo: [CityInfoResponse]) -> [CityInfo] {
        
//        let cities = citiesInfo.compactMap { (city) -> CityInfo? in
//            if let cityName = city.name {
//                return CityInfo(coord: Coordinate(lat: city.coord.lat, lon: city.coord.lon), country: city.country, name: cityName)
//            }
//            return nil
//        }
//
        return  cityListInfo.compactMap{ $0.name != nil ?
            CityInfo(coord: Coordinate(lat: $0.coord.lat,
                                       lon: $0.coord.lon),
                     country: $0.country,
                     name: $0.name!): nil }
    }
}
