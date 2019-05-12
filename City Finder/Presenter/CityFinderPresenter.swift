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
    func getListOfCities(withSearch: Bool) -> Int
    func city(at index: Int, withSearch: Bool) -> CityInfo
    func filterContentForSearchText(_ searchText: String)
}

class CityFinderPresenterImpl: CityFinderPresenter {

    private let cityListUseCase: CityListUseCase
    private weak var cityFinderView: CityFinderView?
    private var dictionaryOfCityList = CityDictionary(dictionaryOfCity: [Character : [CityInfo]]())
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
            case .success(let cityDict, let cityListInfo):
                self?.allCityListInfo = cityListInfo
                self?.dictionaryOfCityList = cityDict
                self?.cityFinderView?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getListOfCities(withSearch: Bool) -> Int {
        if withSearch {
            return filteredCityListInfo.count
        } else {
            return allCityListInfo.count
        }
    }
    
    func city(at index: Int, withSearch: Bool) -> CityInfo {
        if withSearch {
            return filteredCityListInfo[index]
        } else {
            return allCityListInfo[index]
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {

        if let startsWithChar = searchText.first, let citiesStartsWith = dictionaryOfCityList.dictionaryOfCity[startsWithChar]{
            filteredCityListInfo = citiesStartsWith
        }
        
        filteredCityListInfo = filteredCityListInfo.filter{ $0.name.uppercased().starts(with:searchText) }.map { (city) -> CityInfo in
            var filteredCity = city
            filteredCity.distanceFromCurrentLocation =  LocationServiceManager.shared.getCurrentLocation?.distance(from: CLLocation(latitude: city.coord.lat, longitude: city.coord.lon)).toMiles
            return filteredCity
        }

        cityFinderView?.reloadData()
    }

}

