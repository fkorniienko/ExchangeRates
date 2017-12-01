//
//  Constants.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 27.11.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import Alamofire
import UIKit

enum APIEndPoints: Int {
    case getLatest
    case getSelected
    case getBySettings
    var urlSufix: String {
        switch self {
        case .getLatest: return "latest"
        case .getSelected: return "latest?base="
        case .getBySettings: return "latest?symbols="
        }
    }
    
    
    var requestMethod: Alamofire.HTTPMethod{
        switch self {
            
        default: return .get
        }
    }
    
    var bodyParams: [String] {
        switch self {
        default: break
        }
        return []
        
    }
    
    var accessTokenRequared: Bool {
        
        switch self {

        default: return false
        }
    }
    
    var keyPath: String{
        switch self {
            
            
        default:
            return ""
        }
        
    }
    
    var objectType: Bool{
        switch self {
        default: return true
        }
    }
}



let windowSize = (UIApplication.shared.keyWindow?.frame.size)

let documentsDirectory : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
