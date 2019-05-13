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
    var controller: MockCityFinderViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        controller = MockCityFinderViewController()
        let service = CitiesListServicesMock()
        let repository = CityListRepositoryImpl(cityListServices: service)
        let useCase  = CityListUseCaseImpl(cityListRepository: repository)
        presenter = CityFinderPresenterImpl(cityListUseCase: useCase, cityFinderView: controller)
        presenter.dictionaryOfCityList = CityDictionaryMock.mockData()
        //presenter.allCityListInfo = MockCityInfo.getCities()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterWithA_Valid() {
        //when
        presenter.filterContentForSearchText("A")
        XCTAssert(presenter.filteredCityListInfo.count == 2, "filteredCityListInfo must contain 2 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterWithP_Valid() {
        //when
        presenter.filterContentForSearchText("P")
        XCTAssert(presenter.filteredCityListInfo.count == 2, "filteredCityListInfo must contain 2 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterWithB_InValid() {
        //when
        presenter.filterContentForSearchText("B")
        XCTAssert(presenter.filteredCityListInfo.count == 0, "filteredCityListInfo must contain 2 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterWithSpecialChar_InValid() {
        //when
        presenter.filterContentForSearchText("@")
        XCTAssert(presenter.filteredCityListInfo.count == 0, "filteredCityListInfo must contain 2 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testAllCityInfoData_WithEmptyString() {
        //when
        
        let expect = expectation(description: "")
        
        presenter.fetchCityList()
        
        presenter.filterContentForSearchText("")
        
        expect.fulfill()
        
        XCTAssert(presenter.allCityListInfo.count == 16, "allCityListInfo must contain 15 values")
        
        
        
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
        
        wait(for: [expect], timeout: 15)
    }
    
}

class MockCityFinderViewController: CityFinderView {
    
    var reloadDataCalled = false
    func reloadData() {
        reloadDataCalled = true
    }
    
    var showIndicatorCalled = false
    func showIndicator() {
        showIndicatorCalled = true
    }
    
    var hideIndicatorCalled = false
    func hideIndicator() {
        hideIndicatorCalled = true
    }
    
}
