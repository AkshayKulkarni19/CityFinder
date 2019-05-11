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
        
        return cityListInfo.compactMap{ CityInfo(coord: Coordinate(lat: $0.coord.lat,
                                                   lon: $0.coord.lon),
                                 country: $0.country,
                                 name: $0.name )}.sorted(by: { $0.name < $1.name })

    }
}
