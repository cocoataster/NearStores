//
//  Catalogues.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 09/06/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation

class Catalogues {
    var catalogues = [Catalogue]()
    var coupons = [Catalogue]()
    
    init(catalogues: [Catalogue], coupons: [Catalogue]) {
        self.catalogues = catalogues
        self.coupons = coupons
    }
}
