//
//  CitiesListUseCase.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

typealias CityListCompletion = (_ cityList: Result<(CityDictionary, [CityInfo])>) -> Void

protocol CityListUseCase {
    func fetchCityListFromJSON(completionHandler: @escaping CityListCompletion)
}

class CityListUseCaseImpl: CityListUseCase {
    
    private var cityListRepository: CityListRepository
    private var cityListInfo = [CityInfo]()
    private var cityListDict = CityDictionary(dictionaryOfCity: [Character : [CityInfo]]())
    init(cityListRepository: CityListRepository) {
        self.cityListRepository = cityListRepository
    }
    
    func fetchCityListFromJSON(completionHandler: @escaping CityListCompletion) {
        
        if cityListInfo.isEmpty {
            self.cityListRepository.fetchCityListFromJSON {[weak self] (response) in
                guard let weakself = self else { return }
                switch response {
                case .success(let cityListInfo):
                    (weakself.cityListDict, weakself.cityListInfo) = CityUIMapper.convertUImodel(cityListInfo: cityListInfo)
                    completionHandler(.success((weakself.cityListDict, weakself.cityListInfo)))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } else {
            completionHandler(.success((self.cityListDict, self.cityListInfo)))
        }
    }
}
