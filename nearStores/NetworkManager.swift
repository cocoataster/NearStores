//
//  NetworkManager.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 09/06/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerDelegate {
    func dataReceived(data: Any?, error: NSError?)
}

class NetworkManager {
    let baseURL: String = "https://interview-ios.firebaseio.com/offers.json"
    var delegate: NetworkManagerDelegate?
    
    func donwloadCatalogues() {
        Alamofire.request(baseURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
            }
                self.delegate?.dataReceived(data: json, error: nil)
            case .failure(let error):
                self.delegate?.dataReceived(data: nil, error: error as NSError)
            }
        }
    }
}
 
