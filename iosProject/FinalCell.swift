//
//  FinalCell.swift
//  iosProject
//
//  Created by Ankit on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/************************************************************************************
 Author: Ankit Shah
 Purpose: Used to handle outlets for tableview cell in Confirm Order View Controller
 ************************************************************************************/
import UIKit

class FinalCell: UITableViewCell {
    
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblFinalPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
