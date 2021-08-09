//
//  CustomButton.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import UIKit

// The custom button component only take care of corner radius for now. But mor designs can be added here
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setupButton()
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            setupButton()
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet {
            setupButton()
        }
    }
    
    func setupButton() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
    
}
