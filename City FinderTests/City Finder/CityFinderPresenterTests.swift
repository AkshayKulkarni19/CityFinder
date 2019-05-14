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
        presenter.allCityListInfo = MockCityInfo.getCities()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        controller = nil
    }
    
    func testFilterWithA_Valid() {
        //when
        presenter.filterContentForSearchText("A")
        XCTAssertEqual(presenter.filteredCityListInfo.count, 2, "filteredCityListInfo must contain 2 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterWithP_Valid() {
        //when
        presenter.filterContentForSearchText("P")
        XCTAssertEqual(presenter.filteredCityListInfo.count, 2, "filteredCityListInfo must contain 2 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterWithB_InValid() {
        //when
        presenter.filterContentForSearchText("B")
        XCTAssertEqual(presenter.filteredCityListInfo.count, 0, "filteredCityListInfo must contain 0 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterWithSpecialChar_InValid() {
        //when
        presenter.filterContentForSearchText("@")
        XCTAssertEqual(presenter.filteredCityListInfo.count, 0, "filteredCityListInfo must contain 0 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testAllCityInfoData_WithEmptyString() {
        //when
        presenter.filterContentForSearchText("")
        XCTAssertEqual(presenter.allCityListInfo.count, 6, "filteredCityListInfo must contain 6 values")
        XCTAssertTrue(controller.reloadDataCalled, "reloadData() method does not called")
    }
    
    func testFilterDataFromJson() {
        
        //Given
        let expect = expectation(description: "wait until data loads")
        presenter.fetchCityList()
        
        presenter.fetchListcompletion = {
            
            //When
            self.presenter.filterContentForSearchText("A")
            
            //Then
            XCTAssertEqual(self.presenter.allCityListInfo.count, 16, "filteredCityListInfo must contain 16 values")
            XCTAssertTrue(self.controller.showIndicatorCalled, "showIndicator() method does not called")
            XCTAssertTrue(self.controller.hideIndicatorCalled, "hideIndicator() method does not called")
            
            XCTAssertEqual(self.presenter.filteredCityListInfo.count, 1, "filteredCityListInfo must contain 1 values")
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10)
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
