//
//  Apartment.swift
//  ByApartments
//
//  Created by odnairy on 04/08/15.
//  Copyright © 2015 Romanus LC. All rights reserved.
//

import UIKit
import Parse
import Bolts

class Apartment: PFObject, PFSubclassing {
    override class func initialize(){
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String{
        return "Apartment"
    }
    
    @NSManaged var onlinerID : Int
    @NSManaged var priceUSD : Int
    @NSManaged var userAddress : String
    @NSManaged var url : String
    @NSManaged var photoUrl : String
    
    class func findAll() -> BFTask {
        return Apartment.query()!.findObjectsInBackground()
        
//        PFCloud.callFunctionInBackground("apartmentsByGeobox", withParameters:
//            ["n":53.90236604048426,"s":53.880413648385016,"e":27.544527053833008,"w":27.484445571899414]) { (result, error) -> Void in
//            print(result)
//        }
//
//        return []
    }
    
    class func findAllInGeoBox(geobox: [NSObject:AnyObject]) -> BFTask{
        return PFCloud.callFunctionInBackground("apartmentsByGeobox", withParameters: geobox)
    }
    
    class func loadDetails() -> BFTask? {
        return nil
    }
}
