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
    func fetchCityList()
}

class CityFinderPresenterImpl: CityFinderPresenter {
    
    let cityListUseCase: CityListUseCase
    private weak var cityFinderView: CityFinderView?
    var dictionaryOfCityList = CityDictionary(dictionaryOfCity: [Character : [CityInfo]]())
    var filteredCityListInfo = [CityInfo]()
    var allCityListInfo = [CityInfo]()
    
    /// For unit test case
    var fetchListcompletion: (() -> (Void))?
    
    init(cityListUseCase: CityListUseCase, cityFinderView: CityFinderView) {
        self.cityListUseCase = cityListUseCase
        self.cityFinderView = cityFinderView
    }
    
    func fetchCityList() {
        cityFinderView?.showIndicator()
        DispatchQueue.global(qos: .userInteractive).async {
            self.cityListUseCase.fetchCityListFromJSON {[weak self] (result) in
                
                switch result {
                case .success(let cityDict, let cityListInfo):
                    self?.allCityListInfo = cityListInfo
                    self?.dictionaryOfCityList = cityDict
                    DispatchQueue.main.async {
                        self?.cityFinderView?.reloadData()
                        self?.cityFinderView?.hideIndicator()
                        self?.fetchListcompletion?()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.fetchListcompletion?()
                }
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

