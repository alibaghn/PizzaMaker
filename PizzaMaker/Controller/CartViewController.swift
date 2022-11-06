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
            // TODO: how to update list items after adding to cart e.g how to update tableviewdata.count?
            self.tableView.reloadData()
        }

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Tableview Delegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelController.shared.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = ModelController.shared.cartItems[indexPath.row].name
        cell.detailTextLabel?.text = ModelController.shared.cartItems[indexPath.row].priceLabel
        return cell
    }
}
