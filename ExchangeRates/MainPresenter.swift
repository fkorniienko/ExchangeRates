//
//  MainPresenter.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 29.11.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import Foundation

protocol MainPresenterDelegate: class {
    func pushExchangeView(filterStr: String)
}

protocol MainPresenterInterface: class {
    var delegate: MainPresenterDelegate? { get set }
    func requestData()
}

class MainPresenter: MainPresenterInterface {
    weak var delegate: MainPresenterDelegate?
    
    var baseViewData = [ExchangeViewData]()
    let model: BaseModelInterface
    let view: MainViewInterface
    
    init(view: MainViewInterface, model: BaseModelInterface) {
        self.view = view
        self.model = model
        self.view.delegate = self
        self.model.delegate = self
    }
    
    func requestData() {
        self.model.runServerCall()
    }
    
    
}


// MARK - MainViewDelegate
extension MainPresenter: MainViewDelegate {
    func tappedCell(filterStr: String) {
        delegate?.pushExchangeView(filterStr: filterStr)
    }
    func changeButton(strArray: String){
        self.model.runServerCall(filter: strArray)
    }
}


// MARK: - BaseModelDelegate
extension MainPresenter: BaseModelDelegate {
    
    func startingServerCall() {
    }
    
    func baseModelDataReady() {
        self.view.registerCell()
        self.view.updateTableData(data: model.exchangeViewData)
    }
    func filterModelDataReady(){
        self.view.updateTableDataFilter(data: model.exchangeViewData)
    }
    
}
