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
    func showIndicator()
    func hideIndicator()
}

class CityFinderViewController: UIViewController {

    @IBOutlet private weak var cityListTableView: UITableView! {
        didSet {
            cityListTableView.delegate = self
            cityListTableView.dataSource = self
            cityListTableView.allowsSelection = false
            cityListTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
            cityListTableView.register(UINib(nibName: "ErrorTableViewCell", bundle: nil), forCellReuseIdentifier: "ErrorTableViewCell")
            cityListTableView.rowHeight = UITableView.automaticDimension
            cityListTableView.estimatedRowHeight = 64
        }
    }
    
    private let configurator = CityFinderConfiguratorImpl()
    var presenter: CityFinderPresenter?
    private var isNoCityExists = false
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.style = .gray
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(Date())
        configurator.configure(viewController: self)
        setup()
    }
    
    private func setup() {
        presenter?.fetchCityList()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search.PlaceHolder".localized
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Navigation.Title".localized
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator.startAnimating()
    }
    
    private func isSearchActive() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
}

extension CityFinderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if presenter?.getListOfCities(withSearch: isSearchActive()) == 0 {
            isNoCityExists = true
            if activityIndicator.isAnimating {
                return 0
            }
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension CityFinderViewController: CityFinderView {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.cityListTableView.reloadData()
            print(Date())
        }
    }
    
    func showIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideIndicator(){
        activityIndicator.stopAnimating()
    }
}

extension CityFinderViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.filterContentForSearchText(searchText.uppercased())
    }
}
