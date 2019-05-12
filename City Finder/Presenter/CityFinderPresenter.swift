//
//  CityFinderPresenter.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import CoreLocation

protocol CityFinderPresenter {
    func getNumberOfCities() -> Int
    func city(at index: Int) -> CityInfo
    func filterContentForSearchText(_ searchText: String)
}

class CityFinderPresenterImpl: CityFinderPresenter {

    private let cityListUseCase: CityListUseCase
    private weak var cityFinderView: CityFinderView?
    private var filteredCityListInfo = [CityInfo]()
    private var allCityListInfo = [CityInfo]()
    
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
                self?.allCityListInfo = cityListInfo
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
    
    func filterContentForSearchText(_ searchText: String) {
//        filteredCityListInfo = allCityListInfo.filter{ $0.name.lowercased().starts(with: searchText.lowercased()) }
        filteredCityListInfo = allCityListInfo.filter({( city: CityInfo) -> Bool in
            var filteredCity = city
            filteredCity.distanceFromCurrentLocation =  LocationServiceManager.shared.getCurrentLocation?.distance(from: CLLocation(latitude: city.coord.lat, longitude: city.coord.lon))
            return filteredCity.name.lowercased().starts(with:searchText)
        })
        cityFinderView?.reloadData()
    }

}

