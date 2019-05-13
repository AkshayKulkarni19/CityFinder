//
//  CitiesListServicesMock.swift
//  City FinderTests
//
//  Created by Akshay Kulkarni on 13/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import XCTest
@testable import City_Finder

class CitiesListServicesMock: CityListServices {
    
    func fetchCityListFromJSON(completionHandler: @escaping CityListResponseCompletion) {
        do {
            
            guard let path = Bundle(for: type(of: self)).path(forResource: "citiesmock", ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return
            }
            let listOfCities = try JSONDecoder().decode([CityInfoResponse].self, from: data)
            completionHandler(.success(listOfCities))
            
        } catch let error {
            completionHandler(.failure(error))
        }
    }
}
