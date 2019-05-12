//
//  CityFinderConfigurator.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CityFinderConfigurator {
    func configure(viewController: CityFinderViewController)
}

class CityFinderConfiguratorImpl: CityFinderConfigurator {

    func configure(viewController: CityFinderViewController) {
        let service = CityListServicesImpl()
        let repository = CityListRepositoryImpl(cityListServices: service)
        let useCase  = CityListUseCaseImpl(cityListRepository: repository)
        let cityFinderPresenter = CityFinderPresenterImpl(cityListUseCase: useCase, cityFinderView: viewController)
        viewController.presenter = cityFinderPresenter
        
    }
}
