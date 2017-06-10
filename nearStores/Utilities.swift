//
//  Utilities.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 09/06/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Utilities {

    class func loadCataloguesFromJSON(json: JSON) -> Catalogues {
        var catalogues = Catalogues(catalogues: [Catalogue](), coupons: [Catalogue]())
        
        for (_ ,infoCatalogue):(String, JSON) in json {
            
            //Coupons
            if infoCatalogue["coupon"].dictionary != nil {
                //Any near store?
                if ((infoCatalogue["nearest_store"].dictionary) != nil) {
                    let coupon = Catalogue(catalogoId: infoCatalogue["catalog_id"].string!,
                                           isCoupon: true, dateEnd: infoCatalogue["date_end"].string!,
                                           nearestStore: infoCatalogue["nearest_store"].dictionary! as Dictionary<String, AnyObject>,
                                           retailerId: infoCatalogue["retailer_id"].string!,
                                           retailerName: infoCatalogue["retailer_name"].string!)
                    catalogues.coupons.append(coupon)
                } else {
                    let coupon = Catalogue(catalogoId: infoCatalogue["catalog_id"].string!,
                                           isCoupon: true, dateEnd: infoCatalogue["date_end"].string!,
                                           retailerId: infoCatalogue["retailer_id"].string!,
                                           retailerName: infoCatalogue["retailer_name"].string!)
                    catalogues.coupons.append(coupon)
                }
            }
        }
        return catalogues
    }
}

//Alamofire.request(JSON_URL).responseJSON { response in
//    
//    if let JSON = response.result.value as? Array<Dictionary<String,AnyObject>> {
//        
//        for infoCatalogo in JSON {
//            
//            //If data is a Cupon
//            if (infoCatalogo["coupon"] as? Dictionary<String,AnyObject>) != nil {
//                
//                //If there is a store available
//                if (infoCatalogo["nearest_store"] as? Dictionary<String,AnyObject>) != nil {
//                    
//                    let cupon = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon: true, dateEnd: infoCatalogo["date_end"] as! String, nearestStore: infoCatalogo["nearest_store"] as! Dictionary<String,AnyObject>, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
//                    
//                    self.cupones.append(cupon)
//                }
//                    
//                    //If there is no store available
//                else {
//                    
//                    let cupon = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon:true, dateEnd: infoCatalogo["date_end"] as! String, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
//                    
//                    self.cupones.append(cupon)
//                }
//            }
//                
//                //Else, if data is a Catalogo
//            else {
//                
//                if (infoCatalogo["nearest_store"] as? Dictionary<String,AnyObject>) != nil {
//                    
//                    let catalogo = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon: false, dateEnd: infoCatalogo["date_end"] as! String, nearestStore: infoCatalogo["nearest_store"] as! Dictionary<String,AnyObject>, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
//                    
//                    self.catalogos.append(catalogo)
//                }
//                    
//                else {
//                    let catalogo = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon: false, dateEnd: infoCatalogo["date_end"] as! String, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
//                    
//                    self.catalogos.append(catalogo)
//                }
//            }
//        }
//    }
//    self.collection.reloadData()
//    self.refreshControl.endRefreshing()
//}
