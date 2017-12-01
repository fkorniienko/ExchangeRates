//
//  DetailView.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 01.12.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import UIKit

protocol DetailViewDelegate {
    func tapped()
}
protocol DetailViewInterface: class {
    var delegate: DetailViewDelegate? { get set }
    func updateTableData(data: [ExchangeViewData])
}
class DetailView: UIView, UITableViewDataSource, UITableViewDelegate {

    var delegate: DetailViewDelegate?
    var tableData = [ExchangeViewData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func registerCell(){
        tableView.register(UINib(nibName: "ExchangeCell", bundle: nil), forCellReuseIdentifier: "ExchangeCell")
    }
    func updateTableData(data: [ExchangeViewData]) {
        tableData = data
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ExchangeCell = self.tableView.dequeueReusableCell(withIdentifier: "ExchangeCell") as! ExchangeCell
        cell.titleLabel?.text = tableData[indexPath.row].title
        cell.valueLabel.text = tableData[indexPath.row].value
        cell.setNeedsDisplay()
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.tappedCell(at: indexPath)
//    }

}
