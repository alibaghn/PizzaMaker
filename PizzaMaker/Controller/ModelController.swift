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
    var cartItemCount: Int = 0 {
        didSet {
            didCartUpdate?()
        }
    }

    var cartTotalPrice: Double = 0 {
        didSet {
            didCartUpdate?()
        }
    }

    var cartItems: [Pizza] = [] {
        didSet {
            didCartUpdate?()
        }
    }
}
