//
//  DetailPresenter.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 01.12.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import Foundation

protocol DetailPresenterDelegate {
    func something()
}

class DetailPresenter {
    var delegate: DetailPresenterDelegate?
    fileprivate var view: DetailView?
    fileprivate var model: BaseModelInterface
    
    init(view: DetailView, model: BaseModelInterface) {
        self.model = model
        self.view = view
        self.view?.delegate = self
        self.model.detailDelegate = self
//        self.view?.updateTableData(data: model)
    }
    func requestData(_ filter: String) {
        self.model.runServerCall(filterArray: filter)
    }
}

extension DetailPresenter: DetailViewDelegate {
    func tapped() {
        // tapped
    }
}
extension DetailPresenter: DetailModelDelegate {
    
    func filterModelDataReady() {
        self.view?.registerCell()
        self.view?.updateTableData(data: model.exchangeViewData)
    }
    
    
}
