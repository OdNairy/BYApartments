//
//  ApartmentCell.swift
//  ByApartments
//
//  Created by Roman Gardukevich on 05/08/15.
//  Copyright © 2015 Romanus LC. All rights reserved.
//

import UIKit

class ApartmentCell: UICollectionViewCell {
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var apartmentImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.05)
        
    }
    
    override func didMoveToSuperview() {
        guard (self.superview != nil) else { return }
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .AllCorners , cornerRadii: CGSizeMake(8, 16))
        let maskLayer = CAShapeLayer();
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true;
    }
}
