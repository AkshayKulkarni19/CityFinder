//
//  CityFinderPresenter.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CityFinderPresenter {
    func fetchCityList()
}

class CityFinderPresenterImpl: CityFinderPresenter {

    private let cityListUseCase: CityListUseCase
    private weak var cityFinderView: CityFinderView?
   
    init(cityListUseCase: CityListUseCase, cityFinderView: CityFinderView) {
        self.cityListUseCase = cityListUseCase
        self.cityFinderView = cityFinderView
    }
    
    func fetchCityList() {
        cityListUseCase.fetchCityListFromJSON { (result) in
            
            print(Date())
            switch result {
            case .success(let cityListInfo):
                print(cityListInfo.count)
                
                let startsWithA = cityListInfo.filter{ $0.name.lowercased().starts(with: "a") }.sorted(by: { $0.name < $1.name })
                print(Date())
                print(startsWithA.count)
                
            case .failure(let error):
                print(error.localizedDescription)
                //completionHandler(.failure(error))
            }
        }
    }
}
