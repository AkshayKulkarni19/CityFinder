//
//  ViewController.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

protocol CityFinderView: class {
    func reloadData()
}

class CityFinderViewController: UIViewController {

    @IBOutlet private weak var cityListTableView: UITableView! {
        didSet {
            cityListTableView.delegate = self
            cityListTableView.dataSource = self
            cityListTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
            cityListTableView.register(UINib(nibName: "ErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "ErrorTableViewCell")
            cityListTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    let configurator = CityFinderConfiguratorImpl()
    var presenter: CityFinderPresenter?
    var isNoCityExists = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configurator.configure(viewController: self)
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

    }
    
    func isSearchActive() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
}

extension CityFinderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.getListOfCities(withSearch: isSearchActive()) == 0{
            isNoCityExists = true
            return 1
        } else {
            isNoCityExists = false
        }
        return presenter?.getListOfCities(withSearch: isSearchActive()) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isNoCityExists {
            if let errorTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ErrorTableViewCell", for: indexPath) as? ErrorTableViewCell{
                return errorTableViewCell
            }
        } else if let cityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell{
            
            if let city = presenter?.city(at: indexPath.row, withSearch: isSearchActive()) {
                cityTableViewCell.configureCell(with: city)
            }
            
            return cityTableViewCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isNoCityExists {
            return tableView.frame.size.height
        }
        return UITableView.automaticDimension
    }
}

extension CityFinderViewController: CityFinderView {
    
    func reloadData() {
        cityListTableView.reloadData()
    }
}

extension CityFinderViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.filterContentForSearchText(searchText.uppercased())
    }
}
