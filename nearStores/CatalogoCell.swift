//
//  CatalogoCell.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 08/04/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class CatalogoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var catalogoImg: UIImageView!
    @IBOutlet weak var retailerName: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    
    var catalogo: Catalogo!
    var cupon: Catalogo!
    
    func configureCatalogoCell(catalogo: Catalogo) {
        self.catalogo = catalogo
        
        retailerName.text = catalogo.retailerName
        dateEnd.text = dateFormatting(dateString: catalogo.dateEnd)
    }
    
    func configureCuponCell(cupon: Catalogo) {
        self.cupon = cupon
        
        retailerName.text = cupon.retailerName
        dateEnd.text = dateFormatting(dateString: cupon.dateEnd)
    }
    
    //Date Formatting
    func dateFormatting(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: (Double(dateString)!))
        
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        return (dateFormatter.string(from: date))
        
    }
}
