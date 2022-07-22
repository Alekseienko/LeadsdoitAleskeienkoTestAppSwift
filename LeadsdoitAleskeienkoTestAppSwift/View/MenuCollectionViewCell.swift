//
//  MenuCollectionViewCell.swift
//  LeadsdoitAleskeienkoTestAppSwift
//
//  Created by alekseienko on 05.07.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoGameImage:UIImageView!
    
    var menu: SlotModel? {
        didSet {
            if let image = menu?.backgroungImage {
                backgroundImage.image = UIImage(named: image)
            }
            
            if let image2 = menu?.logoImage {
                logoGameImage.image = UIImage(named: image2)
            }
        }
    }
    
}
