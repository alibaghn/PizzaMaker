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
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cart view loaded")
        inCartLabel.text = String(modelController.cartTotalPrice)
        modelController.didCartItemUpdate = {
            print("item added")
            self.inCartLabel.text = String(self.modelController.cartTotalPrice)
            self.tableView.reloadData()
        }
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Tableview Delegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func deleteItem(_ indexPath: IndexPath) {
        modelController.cartTotalPrice -= ModelController.shared.cartItems[indexPath.row].price
        modelController.cartItems.remove(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelController.shared.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.cellTitle.text = ModelController.shared.cartItems[indexPath.row].name + " (\(ModelController.shared.cartItems[indexPath.row].priceLabel))"
        cell.cellDetail.text = ModelController.shared.cartItems[indexPath.row].toppingString
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(indexPath)
        }
    }
}
