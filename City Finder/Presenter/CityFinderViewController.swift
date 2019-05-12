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
            cityListTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    let configurator = CityFinderConfiguratorImpl()
    var presenter: CityFinderPresenter?
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
}

extension CityFinderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchText = searchController.searchBar.text {
            if searchController.isActive && !searchText.isEmpty {
                return presenter?.getNumberOfCities() ?? 0
            }
        }
        return presenter?.getNumberOfCities() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell{
            if let city = presenter?.city(at: indexPath.row) {
                cityTableViewCell.configureCell(with: city)
            }
            return cityTableViewCell
        }
        return UITableViewCell()
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
        presenter?.filterContentForSearchText(searchText.lowercased())
    }
}
