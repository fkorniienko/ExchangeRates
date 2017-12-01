//
//  FetchBaseModel.swift
//  
//
//  Created by Fedir Korniienko on 27.11.17.
//
//

import Foundation
import ObjectMapper
import SwiftyJSON

class FetchBaseModel: NSObject, Mappable{
    
    
    internal let kRatesKey:                     String = "rates"
    internal let kBaseKey:                      String = "base"
    internal let kDateKey:                      String = "date"
    
    public var rates:                           [String : Any] = [:]
    public var base:                            String?
    public var date:                            String?
    
    
    required public init?(map: Map){
        super.init()
    }
    
    required public override init() {
        super.init()
    }
    
    
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }
    
    public init(json: JSON) {
        super.init()
        base            = json[kBaseKey].string
        date            = json[kDateKey].string
        rates           = json[kRatesKey].dictionaryObject ?? [:]

    }
    
    public func mapping(map: Map) {
        base        <- map[kBaseKey]
        date        <- map[kDateKey]
        rates       <- map[kRatesKey]
 
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        
        dictionary.updateValue(rates         as AnyObject, forKey: kRatesKey)
        dictionary.updateValue(base          as AnyObject, forKey: kBaseKey)
        dictionary.updateValue(date          as AnyObject, forKey: kDateKey)
        
        return dictionary
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.rates   = aDecoder.decodeObject(forKey:   kRatesKey)   as? [String : Any] ?? [:]
        self.base    = aDecoder.decodeObject(forKey:   kBaseKey)    as? String
        self.date    = aDecoder.decodeObject(forKey:   kDateKey)    as? String
        
    }
    
    open func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.rates,forKey:    kRatesKey)
        aCoder.encode(self.base,forKey:     kBaseKey)
        aCoder.encode(self.date,forKey:     kDateKey)
        
    }
}
