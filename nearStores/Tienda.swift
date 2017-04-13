//
//  Tienda.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 09/04/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation

class Tienda {
    private var _distance: Double!
    private var _latitude: Double!
    private var _longitude: Double!
    private var _phoneNumber: String!
    private var _storeAddress: String!
    private var _storeCity: String!
    private var _storeName: String!
    private var _storeZipCode: String!
    private var _webURL: String!
    
    var distance: Double {
        if _distance == nil {
            _distance = 0.0
        }
        return _distance
    }
    
    var latitude: Double {
        if _latitude == nil {
            _latitude = 0.0
        }
        return _latitude
    }
    
    var longitude: Double {
        if _longitude == nil {
            _longitude = 0.0
        }
        return _longitude
    }
    
    var phoneNumber: String {
        if _phoneNumber == "" {
            _phoneNumber = ""
        }
        return _phoneNumber
    }
    
    var storeAddress: String {
        if _storeAddress == "" {
            _storeAddress = ""
        }
        return _storeAddress
    }
    
    var storeCity: String {
        if _storeCity == "" {
            _storeCity = ""
        }
        return _storeCity
    }
    
    var storeName: String {
        if _storeName == "" {
            _storeName = ""
        }
        return _storeName
    }
    
    var storeZipCode: String {
        if _storeZipCode == "" {
            _storeZipCode = ""
        }
        return _storeZipCode
    }
    
    var webURL: String {
        if _webURL == "" {
            _webURL = ""
        }
        return _webURL
    }
    
    init() {
    }
    
    init(nearStore: Dictionary<String,AnyObject>) {
        _distance = stringToDouble(string: nearStore["distance"] as! String)
        _latitude = stringToDouble(string: nearStore["latitude"] as! String)
        _longitude = stringToDouble(string: nearStore["longitude"] as! String)
        _phoneNumber = nearStore["phone_number"] as! String
        _storeAddress = nearStore["store_address"] as! String
        _storeCity = nearStore["store_city"] as! String
        _storeName = nearStore["store_name"] as! String
        _storeZipCode = nearStore["store_zip_code"] as! String
        _webURL = nearStore["web_url"] as! String
    }
    
    func stringToDouble(string: String) -> Double {
        
        var result = ""
        
        for character in string.characters {
            let char = "\(character)"
            if char == "," {
                result = result + "."
            } else {
                result = result + char
            }
        }
        return Double(result)!
    }
    
}
