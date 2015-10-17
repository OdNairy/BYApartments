//
//  ApartmentsListViewController.swift
//  ByApartments
//
//  Created by Roman Gardukevich on 05/08/15.
//  Copyright © 2015 Romanus LC. All rights reserved.
//

import UIKit
import PINRemoteImage

private let reuseIdentifier = "Cell"

class ApartmentsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var objects = [Apartment]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let query = Apartment.query()!
//        query.limit = 150
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            self.objects = objects as! [Apartment]
            self.collectionView?.reloadData()
        }
        
        
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds)-20, CGRectGetHeight(self.collectionView!.bounds)*0.8)
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds)/4-5, CGRectGetHeight(self.collectionView!.bounds)*0.8/4)
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
//            //            print(Apartment.findAll())
//            let ob = Apartment.query()!.findObjects()!
//            NSLog("AAA: %@", ob)
//        }
        
//        Apartment.query()?.findObjectsInBackgroundWithBlock({ (newObjects, error) -> Void in
//            self.objects = newObjects as! [Apartment]
//            self.collectionView?.reloadData()
//        })
//        Apartment.query()?.findObjectsInBackgroundWithBlock(){
//            var a = $0.0
//            self.objects = a as! [Apartment]
//            self.collectionView?.reloadData()
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(ApartmentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let flow = self.collectionView?.collectionViewLayout
//
//        
//        flow.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView!.bounds), CGRectGetHeight(self.collectionView!.bounds))

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ApartmentCell
    
        // Configure the cell
        let apartment = self.objects[indexPath.row]
        let priceText = String(format: "$%d", apartment.priceUSD)

        cell.priceLabel.text = priceText
        cell.text.text = apartment.userAddress
        cell.apartmentImageView.image = nil
        
        cell.layoutIfNeeded()
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: apartment.photoUrl)
//        if  url != nil {
//            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
//                guard let saveData = data else {
//                    return
//                }
//                guard let image = UIImage(data: saveData) else {return}
//                cell.apartmentImageView.performSelectorOnMainThread(Selector("setImage:"), withObject: image, waitUntilDone: true)
//            })
//            task.resume()
//        }
        print(url!)
        cell.apartmentImageView.pin_updateWithProgress = true
        cell.apartmentImageView.pin_setImageFromURL(url!)
        
        return cell
    }

//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        var scale : CGFloat = 1
//        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
//            scale = 2
//        }
//        
//        let collectionFlow = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        
//        var viewWidth = CGRectGetWidth(collectionView.bounds) - collectionFlow.sectionInset.left - collectionFlow.sectionInset.right
//        viewWidth = viewWidth/scale
//        
//        return CGSizeMake(viewWidth, collectionView.bounds.size.height*0.8/scale)
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
