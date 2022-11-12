//
//  ViewController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/2/22.
//

import UIKit

class BuildViewController: UIViewController {
    @IBOutlet var crustView: UIImageView!
    @IBOutlet var mushroomView: UIImageView!
    @IBOutlet var pepperView: UIImageView!
    @IBOutlet var peperoniView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var boxBottom: UIImageView!
    @IBOutlet var boxTop: UIImageView!
    @IBOutlet var inCartLabel: UILabel!
    @IBOutlet var smallButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var largeButton: UIButton!
    var currentTopping: Toppings?
    var currentPizza: Pizza = MediumPizza()
    var modelController = ModelController.shared

    func updatePriceLabel() {
        priceLabel.text = currentPizza.priceLabel + "$"
    }

    func currentPizzaPrice() -> Double {
        return currentPizza.price
    }

    func onChangeCrustSize() {
        UIView.animate(withDuration: K.animationDuration) {
            self.crustView.transform = self.crustView.transform.rotated(by: .pi)
            self.crustView.transform = self.crustView.transform.scaledBy(x: self.currentPizza.diameter/self.crustView.frame.width, y: self.currentPizza.diameter/self.crustView.frame.height)
        }
    }

    @IBAction func changePizzaSize(sender: UIButton) {
        smallButton.backgroundColor = .white
        mediumButton.backgroundColor = .white
        largeButton.backgroundColor = .white
        switch sender {
        case smallButton:
            var smallPizza = SmallPizza()
            smallPizza.toppings = currentPizza.toppings
            currentPizza = smallPizza
            smallButton.backgroundColor = .green
            updatePriceLabel()
            onChangeCrustSize()
        case mediumButton:
            var mediumPizza = MediumPizza()
            mediumPizza.toppings = currentPizza.toppings
            currentPizza = mediumPizza
            mediumButton.backgroundColor = .green
            updatePriceLabel()
            onChangeCrustSize()
        case largeButton:
            var largePizza = LargePizza()
            largePizza.toppings = currentPizza.toppings
            currentPizza = largePizza
            currentPizza = LargePizza()
            largeButton.backgroundColor = .green
            updatePriceLabel()
            onChangeCrustSize()
        default:
            break
        }
    }

    func addToCart() {
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.crustView.transform = self.crustView.transform.scaledBy(x: K.pizzaInBoxRatio, y: K.pizzaInBoxRatio)
                self.boxBottom.transform = self.boxBottom.transform.scaledBy(x: K.boxRatio, y: K.boxRatio)
                self.boxTop.transform = self.boxTop.transform.scaledBy(x: K.boxRatio, y: K.boxRatio)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.boxTop.alpha = 1
                self.crustView.alpha = 0
                self.boxBottom.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.boxTop.transform = self.boxTop.transform.translatedBy(x: 0, y: 300)
                self.boxTop.alpha = 0
            }
        } completion: { _ in
            self.modelController.cartItemCount += 1
            self.modelController.cartTotalPrice += self.currentPizza.price
            self.modelController.cartItems.append(self.currentPizza)
            print(self.modelController.cartItems.count)
            self.tabBarController?.viewControllers?[1].tabBarItem.badgeValue = String(self.modelController.cartItemCount)
            self.resetViewSettings()
            self.crustView.image = UIImage(named: "crust")
        }
    }

    func resetViewSettings() {
        crustView.transform = crustView.transform.scaledBy(x: 1/K.pizzaInBoxRatio, y: 1/K.pizzaInBoxRatio)
        boxTop.transform = boxTop.transform.translatedBy(x: 0, y: -300)
        boxBottom.transform = boxBottom.transform.scaledBy(x: 1/K.boxRatio, y: 1/K.boxRatio)
        boxTop.transform = boxTop.transform.scaledBy(x: 1/K.boxRatio, y: 1/K.boxRatio)
        updatePriceLabel()
        onChangeCrustSize()
        crustView.alpha = 1
        boxBottom.alpha = 1
        boxTop.alpha = 0
        currentPizza.toppings = []
    }

    @IBAction func addToCartButton(_ sender: Any) {
        addToCart()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        formatViews()
        print("view loaded")
        inCartLabel.text = String(modelController.cartTotalPrice)
        modelController.didCartUpdate = {
            self.inCartLabel.text = String(self.modelController.cartTotalPrice)
        }
        let mushroomDrag = UIDragInteraction(delegate: self)
        let pepperDrag = UIDragInteraction(delegate: self)
        let peperoniDrag = UIDragInteraction(delegate: self)
        mushroomView.addInteraction(mushroomDrag)
        pepperView.addInteraction(pepperDrag)
        peperoniView.addInteraction(peperoniDrag)
        let toppingDrop = UIDropInteraction(delegate: self)
        view.addInteraction(toppingDrop)
    }
}

// MARK: - DragDelegate

extension BuildViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let touchedPoint = session.location(in: view)
        let touchedImage = view.hitTest(touchedPoint, with: nil) as! UIImageView
        print(touchedImage.tag)
        func selectTopping() {
            switch touchedImage.tag {
            case 0:
                currentTopping = Toppings.Mushroom
            case 1:
                currentTopping = Toppings.Pepper
            case 2:
                currentTopping = Toppings.Peperoni
            default:
                currentTopping = nil
            }
        }
        selectTopping()
        let image = touchedImage.image!
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        print("dragged")
        return [item]
    }
}

// MARK: - DropDelegate

extension BuildViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        let operation: UIDropOperation
        if crustView.frame.contains(dropLocation) {
            operation = .copy
        } else {
            operation = .cancel
        }
        return UIDropProposal(operation: operation)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { imageItems in

            let droppedImages = imageItems as! [UIImage]
            let droppedImage = droppedImages.first!
            let bottomImage = self.crustView.image
            let size = self.crustView.frame.size
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let drawingArea = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            bottomImage!.draw(in: drawingArea)

            func mergeToppingWithCrust(toppingCoordinates: [(Double, Double)]) {
                for tuple in toppingCoordinates {
                    droppedImage.draw(in: CGRect(x: drawingArea.midX + tuple.0, y: drawingArea.midY + tuple.1, width: 50, height: 50), blendMode: .normal, alpha: 1)
                }

                let newImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.crustView.image = newImage
            }

            mergeToppingWithCrust(toppingCoordinates: self.currentPizza.toppingCoordinates)
            self.currentPizza.toppings.append(self.currentTopping!)
        }
    }
}

// MARK: - Styling

extension BuildViewController {
    func formatViews() {
        mushroomView.layer.borderWidth = 1.0
        mushroomView.layer.masksToBounds = false
        mushroomView.layer.borderColor = UIColor.white.cgColor
        mushroomView.layer.cornerRadius = mushroomView.frame.width/2
        mushroomView.clipsToBounds = true

        pepperView.layer.borderWidth = 1.0
        pepperView.layer.masksToBounds = false
        pepperView.layer.borderColor = UIColor.white.cgColor
        pepperView.layer.cornerRadius = mushroomView.frame.width/2
        pepperView.clipsToBounds = true

        peperoniView.layer.borderWidth = 1.0
        peperoniView.layer.masksToBounds = false
        peperoniView.layer.borderColor = UIColor.white.cgColor
        peperoniView.layer.cornerRadius = peperoniView.frame.width/2
        peperoniView.clipsToBounds = true

        smallButton.layer.cornerRadius = 5
        smallButton.layer.borderWidth = 1
        smallButton.layer.borderColor = UIColor.black.cgColor

        mediumButton.layer.cornerRadius = 5
        mediumButton.layer.borderWidth = 1
        mediumButton.layer.borderColor = UIColor.black.cgColor
        mediumButton.backgroundColor = .green

        largeButton.layer.cornerRadius = 5
        largeButton.layer.borderWidth = 1
        largeButton.layer.borderColor = UIColor.black.cgColor
    }
}
