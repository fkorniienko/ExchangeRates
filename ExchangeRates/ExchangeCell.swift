//
//  ExchangeCell.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 27.11.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import UIKit
class ExchangeCell: UITableViewCell{
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func configure(item: [String:Any]) {
        
        titleLabel.text = item.keys.first ?? ""
        valueLabel.text =  (item.first?.value as? Float)?.description ?? ""
    }
}
protocol ItemsView {
    func getItems(items: FetchBaseModel)
}
