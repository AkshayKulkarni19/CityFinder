//
//  CityFinderViewControllerTests.swift
//  City FinderTests
//
//  Created by Balaji Galave on 5/14/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import XCTest
@testable import City_Finder

class CityFinderViewControllerTests: XCTestCase {

    var controller: CityFinderViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupCityFinderViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCityFinderViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        controller = storyboard.instantiateViewController(withIdentifier: "CityFinderViewController") as? CityFinderViewController
    }
    
    func loadView() {
        window.addSubview(controller.view)
        RunLoop.current.run(until: Date())
    }

    func testSetup() {
        //Given
        
        // When
        loadView()
        
        // Then
        XCTAssertNotNil(controller.presenter, "ViewController viewDidload method is not called")
        XCTAssertEqual(controller.navigationItem.title, "Navigation.Title".localized, "ViewController viewDidload method is not called")
    }
}
