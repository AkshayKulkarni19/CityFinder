//
//  CityListUseCaseTests.swift
//  City FinderTests
//
//  Created by Akshay Kulkarni on 13/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import XCTest
@testable import City_Finder

class CityListUseCaseTests: XCTestCase {
    
    var useCase: CityListUseCase!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let service = CitiesListServicesMock()
        let repository = CityListRepositoryImpl(cityListServices: service)
        useCase  = CityListUseCaseImpl(cityListRepository: repository)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let expections = expectation(description: "")
        
        useCase.fetchCityListFromJSON { (result) in
            
            switch result {
            case .success(let cityDict, let cityListInfo):
                print("*************** \(cityListInfo.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            expections.fulfill()
        }
        waitForExpectations(timeout: 30) { (error) in
            print("*************** \(error)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
