//
//  DWButton.swift
//  DNApp
//
//  Created by Trinity on 16/6/23.
//  Copyright © 2016年 Trinity. All rights reserved.
//

import UIKit

@IBDesignable public class DWButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable public var cornerRadius:CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
