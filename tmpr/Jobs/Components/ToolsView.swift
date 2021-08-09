//
//  ToolsView.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import UIKit

class ToolsView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = self.frame.height/2
        dropShadow(color: UIColor(named: "Satin")!, opacity: 0.2, offSet: CGSize(width: 1, height: 1), radius: 8)
    }

}
