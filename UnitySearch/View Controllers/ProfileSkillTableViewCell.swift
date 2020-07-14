//
//  ProfileSkillTableViewCell.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/12.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class ProfileSkillTableViewCell : UITableViewCell {
    
    //property
    var skillName : UITextField!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        skillName.text = nil
    }
    
    func setUpLayout() {
        skillName = UITextField()
        skillName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(skillName)
        
        skillName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        skillName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        skillName.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        skillName.minimumFontSize = 18
        skillName.layer.cornerRadius = 14
        skillName.layer.borderWidth = 1
        skillName.layer.borderColor = UIColor.lightGray.cgColor
        skillName.textAlignment = .center
        skillName.allowsEditingTextAttributes = false
        skillName.backgroundColor = .none
        skillName.adjustsFontSizeToFitWidth = true
        
//        skillName.textAlignment = .center
//        skillName.layer.cornerRadius = 14
//        skillName.clipsToBounds = true
//        skillName.allowsEditingTextAttributes = false
//        skillName.autoresizesSubviews = true
//        skillName.layer.borderColor = UIColor.lightGray.cgColor
//        skillName.layer.borderWidth = 1
//        skillName.textColor = .black
//        skillName.backgroundColor = .white
//        skillName.isScrollEnabled = false

    }
}
