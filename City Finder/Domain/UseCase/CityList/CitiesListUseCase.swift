//
//  CitiesListUseCase.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

typealias CityListCompletion = (_ cityList: Result<[CityInfo]>) -> Void

protocol CityListUseCase {
    func fetchCityListFromJSON(completionHandler: @escaping CityListCompletion)
}

class CityListUseCaseImpl: CityListUseCase {
    
    private var cityListRepository: CityListRepository
    
    init(cityListRepository: CityListRepository) {
        self.cityListRepository = cityListRepository
    }
    
    func fetchCityListFromJSON(completionHandler: @escaping CityListCompletion) {
        self.cityListRepository.fetchCityListFromJSON { (response) in
            
            switch response {
            case .success(let cityListInfo):
                let cityList = CityUIMapper.convertUImodel(cityListInfo: cityListInfo)
                completionHandler(.success(cityList))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
}
