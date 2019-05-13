//
//  CityFinderPresenterTests.swift
//  City FinderTests
//
//  Created by Akshay Kulkarni on 13/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import XCTest
@testable import City_Finder

class CityFinderPresenterTests: XCTestCase {

    var presenter: CityFinderPresenterImpl!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let controller = MockCityFinderViewController()
        let service = CitiesListServicesMock()
        let repository = CityListRepositoryImpl(cityListServices: service)
        let useCase  = CityListUseCaseImpl(cityListRepository: repository)
        
        presenter = CityFinderPresenterImpl(cityListUseCase: useCase, cityFinderView: controller)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfCities() {
        
        //when
        var loadingexp = expectation(description: "")
//        presenter.cityListUseCase.fetchCityListFromJSON { (result) in
//            switch result {
//            case .success(let cityDict, let cityListInfo):
//                XCTAssertTrue(cityListInfo.count > 0, " allCityListInfo count must be greater than 0")
//            case .failure(let error):
//                XCTFail("Failed to load json")
//            }
//            loadingexp.fulfill()
//        }
        
        loadingexp.fulfill()

        //then
        XCTAssertTrue(presenter.allCityListInfo.count > 0, " allCityListInfo count must be greater than 0")
        
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}



class MockCityFinderViewController: CityFinderView {
    
    func reloadData() {
        
    }
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
    
    
}
