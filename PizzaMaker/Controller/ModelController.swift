//
//  ModelController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/22/22.
//

import Foundation

class ModelController {
    static let shared = ModelController()
    var didCartUpdate: (() -> Void)?
    var cartItems: Int = 0 {
        didSet {
            didCartUpdate?()
        }
    }

    var cartTotalPrice: Double = 0 {
        didSet {
            didCartUpdate?()
        }
    }

    
}
