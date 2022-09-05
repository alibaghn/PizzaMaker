//
//  Model.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/5/22.
//

import Foundation


enum PizzaSize {
    case SmallPizza, MediumPizza, LargePizza
}

struct SmallPizza {
    static let price = 10.0
    static let size = 200.0
    static let toppingCoordinates: [(Double,Double)] = [(-50,-50),(10,10),(-110,-110),(10,-110),(-110,10)]
    static var priceLabel: String {
        get {
            return String(format: "%.0f", price)
        }
    }
}

struct MediumPizza {
    static let price = 20.0
    static let size = 250.0
    static let toppingCoordinates: [(Double,Double)] = [(-50,-50),(10,10),(-110,-110),(10,-110),(-110,10)]
    static var priceLabel: String {
        get {
            return String(format: "%.0f", price)
        }
    }
}

struct LargePizza {
    static let price = 30.0
    static let size = 300.0
    static let toppingCoordinates: [(Double,Double)] = [(-50,-50),(10,10),(-110,-110),(10,-110),(-110,10)]
    static var priceLabel: String {
        get {
            return String(format: "%.0f", price)
        }
    }
}






