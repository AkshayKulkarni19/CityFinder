//
//  CitiesListServices.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

typealias CityListResponseCompletion = (_ cityList: Result<[CityInfoResponse]>) -> Void

protocol CityListServices {
    func fetchCityListFromJSON(completionHandler: @escaping CityListResponseCompletion)
}

class CityListServicesImpl: CityListServices {
    
    func fetchCityListFromJSON(completionHandler: @escaping CityListResponseCompletion) {
        
        do {
            guard let data = FileReader.getDataFromFile(fileName: "cities", type: "json") else {
                return
            }
            let listOfCities = try JSONDecoder().decode([CityInfoResponse].self, from: data)
            completionHandler(.success(listOfCities))
            
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
}
