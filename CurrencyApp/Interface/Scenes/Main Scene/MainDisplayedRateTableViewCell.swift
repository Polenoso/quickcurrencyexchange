//
//  MainDisplayedRateTableViewCell.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import UIKit

class MainDisplayedRateTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = String(describing: MainDisplayedRateTableViewCell.self)

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(viewModel: MainModels.GetRates.Displayed) {
        dateLabel.text = viewModel.date
        valueLabel.text = viewModel.value
    }
    
}
