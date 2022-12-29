//
//  Model.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/5/22.
//

import Foundation
import UIKit

enum PizzaSize {
    case Small, Medium, Large
}

enum Toppings {
    case Mushroom, Onion, Peperoni
}

struct SmallPizza: Pizza {
    var image: UIImage?
    let name = "Small Pizza"
    var price: Double = 10.0
    var toppings: [Toppings] = []
    var toppingString: String {
        return toppings.map { String(describing: $0) }.joined(separator: ",")
    }

    var diameter: Double = 200.0
    
    var toppingCoordinates: [(Double, Double)] = [(-30, -30), (25, 25), (-80, -80), (25, -80), (-80, 25)]

    var priceLabel: String {
        return String(format: "%.0f", price) + "$"
    }
}

struct MediumPizza: Pizza {
    var image: UIImage?
    let name = "Medium Pizza"
    var price: Double = 20.0
    var toppings: [Toppings] = []
    var toppingString: String {
        return toppings.map { String(describing: $0) }.joined(separator: ",")
    }

    var diameter: Double = 250.0

    var toppingCoordinates: [(Double, Double)] = [(-30, -30), (30, 30), (-85, -85), (30, -85), (-85, 30)]

    var priceLabel: String {
        return String(format: "%.0f", price) + "$"
    }
}

struct LargePizza: Pizza {
    var image: UIImage?
    let name = "Large Pizza"
    var price: Double = 30.0
    var toppings: [Toppings] = []

    var toppingString: String {
        return toppings.map { String(describing: $0) }.joined(separator: ",")
    }

    var diameter: Double = 300.0

    var toppingCoordinates: [(Double, Double)] = [(-30, -30), (35, 35), (-90, -90), (35, -90), (-90, 35)]

    var priceLabel: String {
        return String(format: "%.0f", price) + "$"
    }
}

protocol Pizza {
    var image: UIImage? { get set }
    var toppingString: String { get }
    var name: String { get }
    var toppings: [Toppings] { get set }
    var price: Double { get }
    var diameter: Double { get }
    var toppingCoordinates: [(Double, Double)] { get }
    var priceLabel: String { get }
}
