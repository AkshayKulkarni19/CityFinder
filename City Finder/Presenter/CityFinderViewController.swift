//
//  ViewController.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

protocol CityFinderView: class {
    
}

class CityFinderViewController: UIViewController {

    let configurator = CityFinderConfiguratorImpl()
    var presenter: CityFinderPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

}

extension CityFinderViewController: CityFinderView {
    
}
