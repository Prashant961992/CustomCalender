//
//  DateViewCollectionCell.swift
//  CalenderDemo
//
//  Created by Prashant on 09/08/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class DateViewCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblData: UILabel!
    
    @IBOutlet weak var viewSelected: UIView!
    
    func selectedCellItem() {
        self.viewSelected.transform = self.viewSelected.transform.scaledBy(x: 0.1, y: 0.1)
        self.viewSelected.backgroundColor = UIColor.black
        self.lblData.textColor = UIColor.white
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.viewSelected.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                self.viewSelected.layer.masksToBounds = true
                self.viewSelected.layer.cornerRadius = self.viewSelected.frame.size.height/2
            }, completion: nil)
        }
    }
    
    func deselectedCellItem() {
        self.viewSelected.layer.masksToBounds = true
        self.viewSelected.layer.cornerRadius = self.viewSelected.frame.size.height/2
        self.viewSelected.backgroundColor = UIColor.clear
        self.lblData.textColor = UIColor.black
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.viewSelected.transform = self.viewSelected.transform.scaledBy(x: 0.1, y: 0.1)
            }, completion: nil)
        }
        
    }
}
