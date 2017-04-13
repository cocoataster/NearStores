//
//  HomeVC.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 08/04/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit
import Alamofire

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collection: UICollectionView!
    
    var catalogos = [Catalogo]()
    var cupones = [Catalogo]()
    var catSection: Int?
    var cupSection: Int?
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        downloadCatalogues()
        refreshControl.addTarget(self, action: #selector(HomeVC.refreshCollection), for: UIControlEvents.valueChanged)
        
        collection.addSubview(refreshControl)
        
    }
    
    //Dequeues the cells and do the set up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == catSection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as? CatalogoCell {
                let catalogo = self.catalogos[indexPath.row]
                cell.configureCatalogoCell(catalogo: catalogo)
                
                return cell
            }
        }
        
        else if indexPath.section == cupSection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCell", for: indexPath) as? CatalogoCell {
                let cupon = self.cupones[indexPath.row]
                cell.configureCuponCell(cupon: cupon)
                
                return cell
            }
        }
        return CatalogoCell()
    }
    
    //Selected Catalog
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == catSection {
            if self.catalogos[indexPath.row].haveStore {
                let tienda = self.catalogos[indexPath.row].nearestStore
                performSegue(withIdentifier: "DetailsVC", sender: tienda)
            }
        }
        
        else if indexPath.section == cupSection {
            if self.cupones[indexPath.row].haveStore {
                let tienda = self.cupones[indexPath.row].nearestStore
                performSegue(withIdentifier: "DetailsVC", sender: tienda)
            }
            else {
                performSegue(withIdentifier: "DetailsVC", sender: nil)
            }
        }
    }
    
    //Prepare for segue to DetailsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVC" {
            if let destination = segue.destination as? DetailsVC {
                if let tienda = sender as? Tienda {
                    destination.store = tienda
                }
            }
        }
    }
    
    //Number of items in each section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == catSection {
            return self.catalogos.count
        }
        
        else if (section == cupSection) {
            return self.cupones.count
        }
        
        return 0
    }
    
    //Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (self.catalogos.count > 0) {
            self.catSection = 0
            if (self.cupones.count > 0) {
                self.cupSection = 1
                return 2
            }
            return 1
        }
        
        else if (self.catalogos.count == 0) {
            if (self.cupones.count > 0) {
                self.cupSection = 0
                return 1
            }
            return 0
        }
        return 0
    }
    
    //Size of items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == cupSection {
            return CGSize(width: 145, height: 180)
        }
        
        else {
            return CGSize(width: 145, height: 220)
        }
    }
    
    //Configure header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == catSection {
            let headerView: CatalogoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CatHeader", for: indexPath) as! CatalogoHeader
            
            headerView.headerTitle.text = "CATÁLOGOS"
            return headerView
        }
        
        else if indexPath.section == cupSection {
            let headerView: CatalogoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CatHeader", for: indexPath) as! CatalogoHeader
            
            headerView.headerTitle.text = "CUPONES"
            return headerView
        }
        
        return CatalogoHeader()
    }
    
    func refreshCollection() {
        self.catalogos.removeAll()
        self.cupones.removeAll()
        self.collection.reloadData()
        downloadCatalogues()
    }
    
    //Data download
    func downloadCatalogues() {
        
        Alamofire.request(JSON_URL).responseJSON { response in
            
            if let JSON = response.result.value as? Array<Dictionary<String,AnyObject>> {
                
                for infoCatalogo in JSON {
                    
                    //If data is a Cupon
                    if (infoCatalogo["coupon"] as? Dictionary<String,AnyObject>) != nil {
                        
                        //If there is a store available
                        if (infoCatalogo["nearest_store"] as? Dictionary<String,AnyObject>) != nil {
                            
                            let cupon = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon: true, dateEnd: infoCatalogo["date_end"] as! String, nearestStore: infoCatalogo["nearest_store"] as! Dictionary<String,AnyObject>, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
                            
                            self.cupones.append(cupon)
                        }
                        
                        //If there is no store available
                        else {
                            
                            let cupon = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon:true, dateEnd: infoCatalogo["date_end"] as! String, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
                            
                            self.cupones.append(cupon)
                        }
                    }
                    
                    //Else, if data is a Catalogo
                    else {
                        
                        if (infoCatalogo["nearest_store"] as? Dictionary<String,AnyObject>) != nil {
                            
                            let catalogo = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon: false, dateEnd: infoCatalogo["date_end"] as! String, nearestStore: infoCatalogo["nearest_store"] as! Dictionary<String,AnyObject>, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
                            
                            self.catalogos.append(catalogo)
                        }
                        
                        else {
                            let catalogo = Catalogo(catalogoId: infoCatalogo["catalog_id"] as! String, isCoupon: false, dateEnd: infoCatalogo["date_end"] as! String, retailerId: infoCatalogo["retailer_id"] as! String, retailerName: infoCatalogo["retailer_name"] as! String)
                            
                            self.catalogos.append(catalogo)
                        }
                    }
                }
            }
            self.collection.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
