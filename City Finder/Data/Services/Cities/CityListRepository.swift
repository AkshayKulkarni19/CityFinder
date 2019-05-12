//
//  CitiesRepository.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 08/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CityListRepository {
    func fetchCityListFromJSON(completionHandler: @escaping CityListResponseCompletion)
}

class CityListRepositoryImpl: CityListRepository {
    
    private var cityListServices: CityListServices
    
    init(cityListServices: CityListServices) {
        self.cityListServices = cityListServices
    }
    
    func fetchCityListFromJSON(completionHandler: @escaping CityListResponseCompletion) {
        cityListServices.fetchCityListFromJSON(completionHandler: completionHandler)
    }
}
