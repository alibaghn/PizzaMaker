//
//  CartViewController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/17/22.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet var inCartLabel: UILabel!
    let modelController = ModelController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        inCartLabel.text = String(modelController.cartTotalPrice)
    }
}
