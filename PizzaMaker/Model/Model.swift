//
//  Model.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/5/22.
//

import Foundation

enum PizzaSize {
    case Small, Medium, Large
}

enum Toppings {
    case Mushroom, Pepper
}

struct SmallPizza {
    static let price = 10.0
    static let diameter = 200.0
    static let toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]
    var toppings: [Toppings] = []
    static var priceLabel: String {
        return String(format: "%.0f", price)
    }
}

struct MediumPizza {
    static let price = 20.0
    var toppings: [Toppings] = []
    static let diameter = 250.0
    static let toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]
    static var priceLabel: String {
        return String(format: "%.0f", price)
    }
}

struct LargePizza {
    static let price = 30.0
    var toppings: [Toppings] = []
    static let diamater = 300.0
    static let toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]
    static var priceLabel: String {
        return String(format: "%.0f", price)
    }
}

