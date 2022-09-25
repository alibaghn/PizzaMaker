//
//  CartViewController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/17/22.
//

import UIKit

class CartViewController: UIViewController{

    @IBOutlet weak var inCartLabel: UILabel!
    let modelController = ModelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inCartLabel.text = String(modelController.cartItems)
    }
    
    
}
