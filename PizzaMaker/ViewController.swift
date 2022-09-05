//
//  ViewController.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 9/2/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum PizzaSize {
    case small, medium, large
    }
    
    @IBOutlet weak var crustView: UIImageView!
    @IBOutlet weak var mushroomView: UIImageView!
    @IBOutlet weak var pepperView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    func updatePriceLabel(size: PizzaSize){
        switch size {
        case .small:
            priceLabel.text = "10$"
        case .medium:
            priceLabel.text = "20$"
        case .large:
            priceLabel.text = "30$"
        }
    }
    
    func rotateAndTransform(size: PizzaSize){
        switch size {
        case .small:
            UIView.animate(withDuration: 2) {
                self.crustView.transform = self.crustView.transform.rotated(by: .pi)
                self.crustView.transform = self.crustView.transform.scaledBy(x: 200/self.crustView.frame.width, y: 200/self.crustView.frame.height)
            }
        case .medium:
            UIView.animate(withDuration: 2) {
                self.crustView.transform = self.crustView.transform.rotated(by: .pi)
                self.crustView.transform = self.crustView.transform.scaledBy(x: 250/self.crustView.frame.width, y: 250/self.crustView.frame.height)
            }
        case .large:
            UIView.animate(withDuration: 2) {
                self.crustView.transform = self.crustView.transform.rotated(by: .pi)
                self.crustView.transform = self.crustView.transform.scaledBy(x: 300/self.crustView.frame.width, y: 300/self.crustView.frame.height)
            }
        }
    }
    
    @IBAction func smallButton(_ sender: UIButton) {
        updatePriceLabel(size: .small)
        rotateAndTransform(size: .small)
    }
    
    @IBAction func mediumButton(_ sender: UIButton) {
        updatePriceLabel(size: .medium)
        rotateAndTransform(size: .medium)
    }
    
    @IBAction func largeButton(_ sender: UIButton) {
        updatePriceLabel(size: .large)
        rotateAndTransform(size: .large)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mushroomDrag = UIDragInteraction(delegate: self)
        let pepperDrag = UIDragInteraction(delegate: self)
        mushroomView.addInteraction(mushroomDrag)
        pepperView.addInteraction(pepperDrag)
        let mushroomDrop = UIDropInteraction(delegate: self)
        view.addInteraction(mushroomDrop)
    }
}

//MARK: - DragDelegate

extension ViewController: UIDragInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let touchedPoint = session.location(in: self.view)
        let touchedImage = view.hitTest(touchedPoint, with: nil) as! UIImageView
        let image = touchedImage.image!
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        print("dragged")
        return [item]
    }
    
}

//MARK: - DropDelegate

extension ViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        let operation: UIDropOperation
        if crustView.frame.contains(dropLocation){
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
            topImage.draw(in: CGRect(x: areaSize.midX - 50, y: areaSize.midY - 50, width: 100, height: 100), blendMode: .normal, alpha: 1)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.crustView.image = newImage
        }
        
    }
    
}










