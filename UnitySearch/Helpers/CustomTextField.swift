//
//  CustomTextField.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/14.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    
    @IBInspectable var inset: CGFloat = 5
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset))
    }
    
    
}
