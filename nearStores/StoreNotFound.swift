//
//  StoreNotFound.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 12/04/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class StoreNotFound: UIView {

    var imageView: UIImageView!
    var info: UILabel!
    
    
    func configureStoreNotFoundView(view: UIView) {
        let contentWith = view.frame.width/2
        
        self.imageView = UIImageView(frame: CGRect(x: view.frame.midX - contentWith/2, y: view.frame.midY - contentWith/2, width: contentWith, height: contentWith))
        
        self.imageView.image = UIImage(named: "sad")
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.info = UILabel(frame: CGRect(x: view.frame.midX - contentWith/2, y: view.frame.midY + contentWith/2, width: contentWith, height: 140))
        self.info.text = "Ups, parece que no hay ninguna tienda cerca"
        self.info.textAlignment = NSTextAlignment.center
        self.info.numberOfLines = 0
    }
    
}
