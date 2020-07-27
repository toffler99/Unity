//
//  Utilities.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/6/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class Utilitites {
    
    static func styleTextField(_ textfield : UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 1, width: textfield.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on textfield
        textfield.borderStyle = .none
        
        // Add the line to the textfield
        textfield.layer.addSublayer(bottomLine)
        textfield.font = UIFont(name: "SFProDisplay-Medium", size: 18)
    }
    
    static func styleRecruiterButton(_ button: UIButton) {
        button.layer.backgroundColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        button.titleLabel!.font = UIFont(name: "SFProDisplay-Medium", size: 18)
    }

    static func styleFilledButton(_ button : UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        button.titleLabel!.font = UIFont(name: "SFProDisplay-Medium", size: 18)
    }
    
    static func styleHollowButton(_ button : UIButton) {
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
        button.titleLabel!.font = UIFont(name: "SFProDisplay-Medium", size: 18)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    // Add email validation
    // Add phone number validation
    
    static func addTopBorder(with view : UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }
    
    static func addBottomBorder(with view: UIView,with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - borderWidth, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }

    static func addLeftBorder(with view: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: view.frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        view.addSubview(border)
    }

    static func addRightBorder(with view: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: view.frame.size.width - borderWidth, y: 0, width: borderWidth, height: view.frame.size.height)
        view.addSubview(border)
    }
    
    static func addBottomBorder(with view: UITextField,with color: UIColor?, andWidth borderWidth: CGFloat) {
           let border = UIView()
           border.backgroundColor = color
           border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
           border.frame = CGRect(x: 0, y: view.frame.size.height - borderWidth, width: view.frame.size.width, height: borderWidth)
           view.addSubview(border)
       }
}

extension UIViewController {
    func setNavigationBackButton(onView : UIViewController,in item : UIImageView = UIImageView() ,bool : Bool) {
        let tapBackBtn = UITapGestureRecognizer(target: onView, action: #selector(popVC))
        item.addGestureRecognizer(tapBackBtn)
        if bool {
            item.translatesAutoresizingMaskIntoConstraints = false
            item.isHidden = false
            let constBackBtn : [NSLayoutConstraint] = [NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal,
                                                                          toItem: nil,
                                                                          attribute: .width, multiplier: 1, constant: 25),
                                                       NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal,
                                                                          toItem: nil,
                                                                          attribute: .height, multiplier: 1, constant: 25),
                                                       NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal,
                                                                          toItem: onView.navigationController?.navigationBar,
                                                                          attribute: .top, multiplier: 1, constant: 8),
                                                       NSLayoutConstraint(item: item, attribute: .leading, relatedBy: .equal,
                                                                          toItem: onView.navigationController?.navigationBar,
                                                                          attribute: .leading, multiplier: 1, constant: 12)]
            onView.navigationController?.navigationBar.addSubview(item)
            onView.navigationController?.navigationBar.addConstraints(constBackBtn)
            item.image = UIImage(named: "leftarrow")
            item.contentMode = .scaleAspectFill
            item.isUserInteractionEnabled = true
        } else {
            item.isHidden = true
            item.removeGestureRecognizer(tapBackBtn)
        }
    }
    
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setEditButton(onView : UIViewController,in item : UIButton = UIButton() ,bool : Bool) {
        if bool {
            item.translatesAutoresizingMaskIntoConstraints = false
            item.isHidden = false
            let constBackBtn : [NSLayoutConstraint] = [NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal,
                                                                          toItem: nil,
                                                                          attribute: .width, multiplier: 1, constant: 50),
                                                       NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal,
                                                                          toItem: nil,
                                                                          attribute: .height, multiplier: 1, constant: 25),
                                                       NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal,
                                                                          toItem: onView.navigationController?.navigationBar,
                                                                          attribute: .bottom, multiplier: 1, constant: -12),
                                                       NSLayoutConstraint(item: item, attribute: .trailing, relatedBy: .equal,
                                                                          toItem: onView.navigationController?.navigationBar,
                                                                          attribute: .trailing, multiplier: 1, constant: -12)]
            onView.navigationController?.navigationBar.addSubview(item)
            onView.navigationController?.navigationBar.addConstraints(constBackBtn)
            item.setTitle("edit", for: .normal)
            item.setTitleColor(.black, for: .normal)
            item.titleLabel!.font = UIFont(name: "SFProDisplay-Medium", size: 20)
            item.layer.borderWidth = 0
            item.isUserInteractionEnabled = true
        } else {
            item.isHidden = true
        }
    }
    
}

extension CALayer {
    func addBorder(_ arr_edge : [UIRectEdge], color : UIColor, width : CGFloat ) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top :
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom :
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.right :
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.left :
                border.frame = CGRect.init(x: 0, y: 0 , width: width, height: frame.height)
                break
            default:
                break
            }
            border.borderColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

