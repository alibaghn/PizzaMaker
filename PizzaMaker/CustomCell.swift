//
//  CustomCell.swift
//  PizzaMaker
//
//  Created by Ali Bagherinia on 11/11/22.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellDetail: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
