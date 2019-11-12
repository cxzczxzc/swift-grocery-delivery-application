//
//  TvSiteCell.swift
//  iosProject
//
//  Created by Surbhi Handa on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/***********************************************************************************
 Author: Surbhi Handa
 Purpose: Single TvSiteCell
 *************************************************************************************/
import UIKit

class TvSiteCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    //@IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    var index : Int = 0
    var price : Double = 0
    var count = 0;

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
