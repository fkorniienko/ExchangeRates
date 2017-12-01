//
//  BaseModel.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 29.11.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol BaseModelDelegate: class {
    func startingServerCall()
    func baseModelDataReady()
    func filterModelDataReady()
}
protocol DetailModelDelegate: class {
    func filterModelDataReady()
}

protocol BaseModelInterface: class {
    var delegate: BaseModelDelegate? { get set }
    var detailDelegate: DetailModelDelegate? { get set }
    var exchangeModelData: [BaseModel] { get }
    var exchangeViewData: [ExchangeViewData] { get }
    var navigationDelegate: NavigationTitleDelegate? { get set }

    func runServerCall()
    func runServerCall(filter: String)
    func baseViewData(fetchModeData: FetchBaseModel) -> [ExchangeViewData]
    func runServerCall(filterArray: String)
}

class BaseModel: BaseModelInterface {
    
    weak var delegate: BaseModelDelegate?
    weak var detailDelegate: DetailModelDelegate?
    weak var navigationDelegate: NavigationTitleDelegate?
    
    var exchangeModelData = [BaseModel]()
    var exchangeViewData = [ExchangeViewData]()
    
    func runServerCall() {
        
        self.delegate?.startingServerCall()
        
        ServerManager.sharedManager.fetchDataWithEndPoint(type: FetchBaseModel.init(json: JSON.null), endPoint: .getLatest) { (data, error) in
            if let data = data as? FetchBaseModel{
                
                self.exchangeViewData = self.baseViewData(fetchModeData: data)
                
                DispatchQueue.main.async {
                    self.delegate?.baseModelDataReady()
                    self.navigationDelegate?.changeTitle(title: data.base ?? "")
                }
                
            }
        }
        
    }
    
    func baseViewData(fetchModeData: FetchBaseModel) -> [ExchangeViewData] {
        var baseViewData: [ExchangeViewData] = []
        let data = fetchModeData.rates
        for fetch in data {
            
            baseViewData.append(ExchangeViewData(title: (fetchModeData.base ?? "") + "/" + fetch.key, value: (fetch.value as! Float).description, titleFilter: fetch.key))
        }
        
        return baseViewData
    }
    func detailViewData(fetchModeData: FetchBaseModel) -> [ExchangeViewData] {
        var baseViewData: [ExchangeViewData] = []
        let data = fetchModeData.rates
        for fetch in data {
            
            baseViewData.append(ExchangeViewData(title: fetch.key, value: (fetch.value as! Float).description, titleFilter: fetch.key))
        }
        
        return baseViewData
    }
    
    func runServerCall(filter: String){
        ServerManager.sharedManager.fetchDataWithEndPoint(type: FetchBaseModel.init(json: JSON.null), endPoint: .getSelected, urlStringParams: filter) { (data, error) in
            if let data = data as? FetchBaseModel{
                
                self.exchangeViewData = self.baseViewData(fetchModeData: data)
                
                DispatchQueue.main.async {
                    self.delegate?.filterModelDataReady()
                    self.navigationDelegate?.changeTitle(title: data.base ?? "")
                }
                
            }
        }
    }
    func runServerCall(filterArray: String){
        ServerManager.sharedManager.fetchDataWithEndPoint(type: FetchBaseModel.init(json: JSON.null), endPoint: .getBySettings, urlStringParams: filterArray) { (data, error) in
            if let data = data as? FetchBaseModel{
                
                self.exchangeViewData = self.detailViewData(fetchModeData: data)
                
                DispatchQueue.main.async {
                    self.detailDelegate?.filterModelDataReady()
                }
            }
        }
    }
}
