//
//  CheckskillTableViewCell.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/11.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import GDCheckbox

class CheckSkillTableViewCell : UITableViewCell {
  
    //property
    var backView : UIView = UIView()
    var checkBox : GDCheckbox = GDCheckbox()
    var skillName : UILabel = UILabel()
    var isOn : Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setGDCheckBox()
    }
    
    override func prepareForReuse() {
        skillName.text = nil
        checkBox.isOn = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CheckSkillTableViewCell {
    //setUp Layout
    func setUpLayout() {
        self.addSubview(backView)
        backView.addSubview(checkBox)
        backView.addSubview(skillName)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        skillName.translatesAutoresizingMaskIntoConstraints = false
        
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        checkBox.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8).isActive = true
        checkBox.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        skillName.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 8).isActive = true
        skillName.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 4).isActive = true
        skillName.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0).isActive = true
        skillName.heightAnchor.constraint(equalToConstant: 36).isActive = true
        skillName.textAlignment = .left
        skillName.font = UIFont.boldSystemFont(ofSize: 16)
    
    }
    
    func setGDCheckBox() {
        // Background color of the box
        checkBox.baseColor = UIColor.white

        // In case of check box, determine the animation duration of the check mark
        checkBox.animationDuration = 0.1

        // Determine if check mark should fill with animation
        checkBox.shouldAnimate = false

        // Color of the check mark / fill area -- no matter if isCurcular is on or off
        checkBox.checkColor = UIColor.black

        // Width of the check mark / fill area -- no matter if isCurcular is on or off
        checkBox.checkWidth = 1

        // Color of container border. If shouldFillContainer is set to true, container background also will be override with this color when CheckBox / Radio Button is selected.
        checkBox.containerColor = #colorLiteral(red: 0.1843137255, green: 0.1411764706, blue: 0.1333333333, alpha: 0.199261582)

        // Determine if container should be filled when selected
        // Note: if set to true, it will override `baseColor` when control is selected
        checkBox.shouldFillContainer = false

        // Border width of container view
        checkBox.containerWidth = 0

        // Determine if it's a check box or a radio button
        checkBox.isRadioButton = false
        
        // Determine container shpae type for selected state
        // For CheckBox -> Check mark when true or square when false
        // For RadioButton -> Check mark when true or circle when false
        checkBox.showCheckMark = true

        // Set default state of the control
        checkBox.isOn = false
    }
}
