//
//  CardView.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import UIKit

class CardView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCardView()
    }
    
    func setupCardView() {
        layer.cornerRadius = 8.0
        dropShadow(color: UIColor(named: "Satin")!, opacity: 0.15, offSet: CGSize(width: 1, height: 1), radius: 8)
    }

}
