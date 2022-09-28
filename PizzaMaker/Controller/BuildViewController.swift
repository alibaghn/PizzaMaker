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
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var boxBottom: UIImageView!
    @IBOutlet var boxTop: UIImageView!
    @IBOutlet var inCartLabel: UILabel!
    var modelController = ModelController.shared

    

    func updatePriceLabel(size: PizzaSize) {
        switch size {
        case .SmallPizza:
            priceLabel.text = SmallPizza.priceLabel + "$"
        case .MediumPizza:
            priceLabel.text = MediumPizza.priceLabel + "$"
        case .LargePizza:
            priceLabel.text = LargePizza.priceLabel + "$"
        }
    }

    func onChangeCrustSize(size: PizzaSize) {
        switch size {
        case .SmallPizza:
            UIView.animate(withDuration: K.animationDuration) {
                self.crustView.transform = self.crustView.transform.rotated(by: .pi)
                self.crustView.transform = self.crustView.transform.scaledBy(x: SmallPizza.size/self.crustView.frame.width, y: SmallPizza.size/self.crustView.frame.height)
            }
        case .MediumPizza:
            UIView.animate(withDuration: K.animationDuration) {
                self.crustView.transform = self.crustView.transform.rotated(by: .pi)
                self.crustView.transform = self.crustView.transform.scaledBy(x: MediumPizza.size/self.crustView.frame.width, y: MediumPizza.size/self.crustView.frame.height)
            }
        case .LargePizza:
            UIView.animate(withDuration: K.animationDuration) {
                self.crustView.transform = self.crustView.transform.rotated(by: .pi)
                self.crustView.transform = self.crustView.transform.scaledBy(x: LargePizza.size/self.crustView.frame.width, y: LargePizza.size/self.crustView.frame.height)
            }
        }
    }

    @IBAction func smallButton(_ sender: UIButton) {
        updatePriceLabel(size: .SmallPizza)
        onChangeCrustSize(size: .SmallPizza)
    }

    @IBAction func mediumButton(_ sender: UIButton) {
        updatePriceLabel(size: .MediumPizza)
        onChangeCrustSize(size: .MediumPizza)
    }

    @IBAction func largeButton(_ sender: UIButton) {
        updatePriceLabel(size: .LargePizza)
        onChangeCrustSize(size: .LargePizza)
    }

    func addToCart() {
        
        modelController.cartItems += 1
        
    }

    @IBAction func addToCartButton(_ sender: Any) {
        addToCart()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        inCartLabel.text = String(modelController.cartItems)
        modelController.didCartUpdate = {
            self.inCartLabel.text = String(self.modelController.cartItems)
        }
        let mushroomDrag = UIDragInteraction(delegate: self)
        let pepperDrag = UIDragInteraction(delegate: self)
        mushroomView.addInteraction(mushroomDrag)
        pepperView.addInteraction(pepperDrag)
        let mushroomDrop = UIDropInteraction(delegate: self)
        view.addInteraction(mushroomDrop)
    }
}

// MARK: - DragDelegate

extension BuildViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let touchedPoint = session.location(in: view)
        let touchedImage = view.hitTest(touchedPoint, with: nil) as! UIImageView
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
            let topImage = droppedImage
            let size = self.crustView.frame.size
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            bottomImage!.draw(in: areaSize)

            func duplicateTopImage(toppingCoordinates: [(Double, Double)]) {
                for tuple in toppingCoordinates {
                    let customToppingView: UIImageView = .init(frame: CGRect(x: self.crustView.frame.midX + tuple.0, y: self.crustView.frame.midY + tuple.1 - 10, width: 100, height: 100))
                    customToppingView.image = droppedImage
                    self.view.addSubview(customToppingView)
                    UIView.animate(withDuration: K.animationDuration) {
                        customToppingView.transform = customToppingView.transform.translatedBy(x: 0, y: +10)
                    }
                    topImage.draw(in: CGRect(x: areaSize.midX + tuple.0, y: areaSize.midY + tuple.1, width: 100, height: 100), blendMode: .normal, alpha: 1)
                }
                let newImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.crustView.image = newImage
            }
            duplicateTopImage(toppingCoordinates: MediumPizza.toppingCoordinates)
        }
    }
}
