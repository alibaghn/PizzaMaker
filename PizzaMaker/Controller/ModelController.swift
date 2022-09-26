//
//  ModelController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/22/22.
//

import Foundation



class ModelController {
    
    static let shared = ModelController()
    var cartDelegate: CartDelegate?
    var cartItems = 0 {
        didSet {
            cartDelegate?.didCartUpdate()
        }
    }
    
}



