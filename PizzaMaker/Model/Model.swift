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

struct SmallPizza: Pizza {
    var price: Double = 10.0
    var toppings: [Toppings] = []

    var diameter: Double = 200.0

    var toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]

    var priceLabel: String {
        return String(format: "%.0f", price)
    }
}

struct MediumPizza: Pizza {
    var price: Double = 20.0
    var toppings: [Toppings] = []

    var diameter: Double = 250.0

    var toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]

    var priceLabel: String {
        return String(format: "%.0f", price)
    }
}

struct LargePizza: Pizza {
    var price: Double = 30.0
    var toppings: [Toppings] = []

    var diameter: Double = 300.0

    var toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]

    var priceLabel: String {
        return String(format: "%.0f", price)
    }

//    static var price = 30.0
//    var toppings: [Toppings] = []
//    static var diamater = 300.0
//    static var toppingCoordinates: [(Double, Double)] = [(-50, -50), (10, 10), (-110, -110), (10, -110), (-110, 10)]
//    static var priceLabel: String {
//        return String(format: "%.0f", price)
//    }
}

protocol Pizza {
    var toppings: [Toppings] {get set}
    var price: Double { get }
     var diameter: Double { get }
     var toppingCoordinates: [(Double, Double)] { get }
     var priceLabel: String { get }
}
