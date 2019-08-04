//
//  ClvCell.swift
//  week6
//
//  Created by Trương Quốc Tài on 7/21/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class ClvCell: UICollectionViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgNote: UIImageView!
    @IBOutlet weak var vcontainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vcontainer.layer.borderWidth = 1
        self.vcontainer.layer.borderColor = UIColor.black.cgColor
        self.imgNote.layer.cornerRadius = self.imgNote.frame.width/2
    }

}
