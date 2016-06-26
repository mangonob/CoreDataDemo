//
//  DWTextField.swift
//  DNApp
//
//  Created by Trinity on 16/6/25.
//  Copyright © 2016年 Trinity. All rights reserved.
//

import UIKit

@IBDesignable public class DWTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable public var placeholderColor: UIColor = UIColor.clearColor() {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                attributes: [NSForegroundColorAttributeName: placeholderColor])
            layoutSubviews()
        }
    }
    
    @IBInspectable public var sidePadding: CGFloat = 0.0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, sidePadding, 0))
            
            self.leftViewMode = UITextFieldViewMode.Always
            self.leftView = padding
            
            self.rightViewMode = UITextFieldViewMode.Always
            self.rightView = padding
        }
    }
    
    @IBInspectable public var leftPadding: CGFloat = 0.0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, leftPadding, 0))
            
            self.leftViewMode = UITextFieldViewMode.Always
            self.leftView = padding
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat = 0.0 {
        didSet {
            let padding = UIView(frame: CGRectMake(0, 0, rightPadding, 0))
            
            self.rightViewMode = UITextFieldViewMode.Always
            self.rightView = padding
        }
    }
}
