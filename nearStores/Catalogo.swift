//
//  Catalogo.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 08/04/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation

class Catalogo {
    
    private var _catalogoId: String!
    private var _isCoupon: Bool!
    private var _dateEnd: String
    private var _nearestStore: Tienda!
    private var _haveStore: Bool!
    private var _retailerId: String!
    private var _retailerName: String!
    
    var catalogoId: String {
        return _catalogoId
    }
    
    var isCoupon: Bool {
        return _isCoupon
    }
    
    var dateEnd: String {
        return _dateEnd
    }
    
    var nearestStore: Tienda {
        if _nearestStore == nil {
            _nearestStore = Tienda()
        }
        return _nearestStore
    }
    
    var haveStore: Bool {
        return _haveStore
    }
    
    var retailerId: String {
        return _retailerId
    }
    
    var retailerName: String {
        return _retailerName
    }
    
    init(catalogoId: String, isCoupon: Bool, dateEnd: String, retailerId: String, retailerName: String) {
        
        self._catalogoId = catalogoId
        self._isCoupon = isCoupon
        self._dateEnd = dateEnd
        self._nearestStore = Tienda()
        self._haveStore = false
        self._retailerId = retailerId
        self._retailerName = retailerName
        
    }
    
    init(catalogoId: String, isCoupon: Bool, dateEnd: String, nearestStore: Dictionary<String,AnyObject>, retailerId: String, retailerName: String) {
        
        self._catalogoId = catalogoId
        self._isCoupon = isCoupon
        self._dateEnd = dateEnd
        self._nearestStore = Tienda(nearStore: nearestStore)
        self._haveStore = true
        self._retailerId = retailerId
        self._retailerName = retailerName
        
    }
    
}
