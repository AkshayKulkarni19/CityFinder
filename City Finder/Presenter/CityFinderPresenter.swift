//
//  CityFinderPresenter.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CityFinderPresenter {
    func getNumberOfCities() -> Int
    func city(at index: Int) -> CityInfo
}

class CityFinderPresenterImpl: CityFinderPresenter {

    private let cityListUseCase: CityListUseCase
    private weak var cityFinderView: CityFinderView?
    private var filteredCityListInfo = [CityInfo]()
    
    init(cityListUseCase: CityListUseCase, cityFinderView: CityFinderView) {
        self.cityListUseCase = cityListUseCase
        self.cityFinderView = cityFinderView
        self.fetchCityList()
    }
    
    private func fetchCityList() {
        cityListUseCase.fetchCityListFromJSON {[weak self] (result) in
        
            switch result {
            case .success(let cityListInfo):
                print(cityListInfo.count)
                self?.filteredCityListInfo = cityListInfo
                self?.cityFinderView?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                //completionHandler(.failure(error))
            }
        }
    }
    
    func getNumberOfCities() -> Int {
        return filteredCityListInfo.count
    }
    
    func city(at index: Int) -> CityInfo {
        return filteredCityListInfo[index]
    }
}

