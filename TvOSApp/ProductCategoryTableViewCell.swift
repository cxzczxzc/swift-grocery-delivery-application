//
//  ProductCategoryTableViewCell.swift
//  iosProject
//
//  Created by Surbhi Handa on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/***********************************************************************************
 Author: Surbhi Handa
 Purpose: Single Product Cell
 *************************************************************************************/
import UIKit

class ProductCategoryTableViewCell: UITableViewCell {
    
// define labels for images and labels in table cell
    @IBOutlet var lblCategory : UILabel!
    @IBOutlet var imgCategory : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
