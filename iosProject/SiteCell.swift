//
//  SiteCell.swift
//  iosProject
//
//  Created by Saad  on 2017-12-27.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/*******************************************************************************************
 Author: Saad Ahmad
 Purpose: Used to handle outlets for tableview cell in Select Items View Controller
 *******************************************************************************************/
import UIKit

class SiteCell: UITableViewCell {

    @IBOutlet weak var hiddenURLS: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var lblFinalPrice: UILabel!

    var index : Int = 0
    var price : Double = 0
    var count = 0;
    override func awakeFromNib() {
        addToCartButton.layer.cornerRadius = 5
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func removeItem(_ sender: Any) {
        self.count = self.count == 0 ? 0 : self.count - 1
        self.quantityLabel.text=String(count)
    }
    @IBAction func addItem(_ sender: Any) {
        self.count = self.count + 1
        self.quantityLabel.text = String(count)
    }
/**********************************************************************************************
 *    Author: Saad Ahmad                                                                      *
 *    This method creates a dictionary of objects of type OrderItem                           *
 *    A dictionary is highly suitable for adding/ removing items to and from cart,            *
 *   because of updateValue and removeValue methods. An item is added with key = item's name. *
 *    If an item is of type X and any changes are made to it, then the code will look for     *
 *     item with key = X and update the changes to it                                         *
 **********************************************************************************************/
    @IBAction func addToCart(_ sender: Any) {
        let quantity = Int(self.quantityLabel.text!)!
        let finalPrice = Double(quantity) * self.price
        let itemName = self.itemLabel.text
        let itemCategory = self.categoryLabel.text
        let itemURL = self.hiddenURLS.text
        let orderItem = OrderItem.init(itemPrice: self.price, finalPrice : finalPrice, itemName: itemName!, itemQuantity: quantity, itemCategory: itemCategory!, itemURL: itemURL!)
        if quantity == 0 {
            orderDetails.removeValue(forKey: itemName!)
        }
        else
        {
        orderDetails.updateValue(orderItem!, forKey: itemName!)
        }
        
    }
    public func resetLabel()
    {
        self.quantityLabel.text = "0"
    }
    }

