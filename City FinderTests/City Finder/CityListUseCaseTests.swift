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

    func testFetchData() {
        
        let expection = expectation(description: "")
        //when
        useCase.fetchCityListFromJSON { (result) in
            
            switch result {
            case .success(let cityDict, let cityListInfo):
                
                //then
                XCTAssertNotNil(cityDict)
                XCTAssertNotNil(cityDict)
                XCTAssertTrue(cityDict.dictionaryOfCity.count > 0)
                XCTAssertTrue(cityListInfo.count > 0)
                
                expection.fulfill()
                
            case .failure(let error):
               XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expection], timeout: 10)
    }

}
