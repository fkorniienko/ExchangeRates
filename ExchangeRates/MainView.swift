//
//  MainView.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 29.11.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import UIKit

struct ExchangeViewData {
    let title: String
    let value: String
    let titleFilter: String
}

protocol NavigationTitleDelegate: class{
    func changeTitle(title: String)
}

protocol MainViewDelegate: class {
    func tappedCell(filterStr : String)
    func changeButton(strArray: String)
}

protocol MainViewInterface: class {
    var delegate: MainViewDelegate? { get set }
    func registerCell()
    func updateTableData(data: [ExchangeViewData])
    func updateTableDataFilter(data: [ExchangeViewData])
}

class MainView: UIView, MainViewInterface, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: MainViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var tableData = [ExchangeViewData]()
    
    var selectedButton = UIButton(){
        willSet{
            setButtonColor(selectedButton, isSelected: false)
        }
        didSet(newButton){
            if newButton == selectedButton{
                setButtonColor(selectedButton, isSelected: false)
            }else{
                setButtonColor(selectedButton, isSelected: true)
            }
        }
    }
    // MARK: - MainViewInterface
 
    
    func updateTableData(data: [ExchangeViewData]) {
        tableData = data
        tableView.reloadData()
        setupScrollView()
    }
    
    func updateTableDataFilter(data: [ExchangeViewData]){
        tableData = data
        tableView.reloadData()
    }
    func registerCell(){
        tableView.register(UINib(nibName: "ExchangeCell", bundle: nil), forCellReuseIdentifier: "ExchangeCell")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filter = tableData[indexPath.row].title.replacingOccurrences(of: "/", with: ",")
        delegate?.tappedCell(filterStr: filter)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func setupScrollView(){
        scrollView.showsHorizontalScrollIndicator = false
        for page in 0..<tableData.count {
            let x = selectedButton.frame.width == 0 ? 5 : selectedButton.frame.width + selectedButton.frame.origin.x
            let xOrigin = x == CGFloat(5) ? 5 : x + 5
            let button = UIButton()
            button.setTitle(tableData[page].titleFilter, for: .normal)
            
            button.tag = page
            let labelSize = button.titleLabel?.sizeThatFits(CGSize(width: (button.titleLabel?.frame.width)!, height: button.frame.size.height)) ?? CGSize.zero
            button.frame = CGRect(x: xOrigin,y: 0,width: labelSize.width,height: scrollView.frame.height)
            button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
            button.setTitleColor(.blue, for: .normal)
            
            button.titleLabel?.font =  UIFont(name: button.titleLabel?.font.fontName ?? "", size: 12)
            button.backgroundColor = .white
            button.isSelected = false
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
            selectedButton = button
            
            self.scrollView.addSubview(button)
        }
        setButtonColor(selectedButton, isSelected: false)
        self.scrollView.contentSize = CGSize(width: selectedButton.frame.width + selectedButton.frame.origin.x + 5, height: self.scrollView.frame.size.height)
    }
    func buttonPress(_ button: UIButton){
        selectedButton = button
        delegate?.changeButton(strArray: tableData[button.tag].titleFilter)
    }
    
    func setButtonColor(_ button: UIButton,isSelected: Bool){
        button.backgroundColor = isSelected ? .blue : .white
        button.setTitleColor(isSelected ? UIColor.white : UIColor.blue, for: .normal)
    }
}





