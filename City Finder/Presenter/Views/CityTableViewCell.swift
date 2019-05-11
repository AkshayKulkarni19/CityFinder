//
//  CityTableViewCell.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 10/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var country: UILabel!
    @IBOutlet private weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with city: CityInfo) {
        cityName.text = city.name
        country.text = city.country
    }
    
}
