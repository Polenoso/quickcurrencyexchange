//
//  DetailRateValueTableViewCell.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import UIKit

class DetailRateValueTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = String(describing: DetailRateValueTableViewCell.self)
    
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateUI(data: DetailRateModels.DisplayedValue) {
        valueLabel.text = data.value
        symbolLabel.text = data.symbol
    }
}
