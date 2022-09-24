//
//  ModelController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/22/22.
//

import Foundation



class ModelController {
    var cartItems = 0 {
        didSet {
            cartDelegate?.didCartUpdate()
        }
    }
    var cartDelegate: CartDelegate?
}



