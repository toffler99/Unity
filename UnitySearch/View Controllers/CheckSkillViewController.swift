//
//  CheckSkillViewController.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/10.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import GDCheckbox
import Firebase

protocol SelectSkillDelegate : class {
    func selectSkillDelegate(skillList : [String])
}

class CheckSkillViewController : UIViewController {
    
    //delegate
    weak var selectSkillDelegate : SelectSkillDelegate!
    
    //property
    private var goBackBtn : UIImageView = UIImageView()
    private var saveBtn : UIImageView = UIImageView()
    private var skillListTableView : UITableView!
    private var lineImg : UIImageView!
    private var skillList : [String] = ["Accounting Clerk","Accounts Payable","Accounts Receivable","Admin Assistant",
                                        "Bookkeeper","Cash Applications","Collections","Credit Analyst","Data Entry",
                                        "Payroll Accountant","Helpdesk Desktop","Quality Assurance"]
    
    private var selectedSkillList : [String:Bool] = ["Accounting Clerk" : false, "Accounts Payable" : false,
                                                     "Accounts Receivable" : false, "Admin Assistant" : false,
                                                     "Bookkeeper" : false, "Cash Applications" : false,
                                                     "Collections" : false, "Credit Analyst" : false, "Data Entry" : false,
                                                     "Payroll Accountant" : false, "Helpdesk Desktop" : false, "Quality Assurance" : false ]
    
    var addSkillList : [String] = [] {
        didSet {
            let db = Firestore.firestore()
            guard let userDefualtID = UserDefaults.standard.object(forKey: "myID") else {return}
            
            let useridPath = db.collection("users").document("\(userDefualtID)")
            useridPath.updateData(["skills" : self.addSkillList])
            
        }
        
    }
    //lifeCycle
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Skill"
        self.navigationItem.hidesBackButton = true
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: goBackBtn, bool: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: goBackBtn, bool: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveBtn.isHidden = true
    }
    
    func appendSkillList(skillName : String) {
        let skill = selectedSkillList[skillName]
        if skill == false {
            selectedSkillList[skillName] = true
        } else {
            return
        }
    }
    
    func removeSkillList(skillName : String) {
        let skill = selectedSkillList[skillName]
        if skill == true {
            selectedSkillList[skillName] = false
        } else {
            return
        }
    }
    
    func updateSkillList() {
        for skill in selectedSkillList {
            switch skill.value {
            case true:
                let skillName = skill.key
                addSkillList.append(skillName)
                print(addSkillList)
            case false:
                break
            }
        }
    }
    
    @objc func saveSkill() {
        updateSkillList()
        self.selectSkillDelegate.selectSkillDelegate(skillList: addSkillList)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CheckSkillViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CheckSkillTableViewCell
        let skill = cell.skillName.text
        switch cell.isOn {
        case false:
            cell.isOn = true
            cell.checkBox.isOn = true
            appendSkillList(skillName: skill!)
        case true:
            cell.isOn = false
            cell.checkBox.isOn = false
            removeSkillList(skillName: skill!)
        }
        print("select \(selectedSkillList)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckSkillTableViewCell", for: indexPath) as! CheckSkillTableViewCell
        //        cell.checkBox.isOn = false
        print("deselect \(indexPath.row)")
    }
    
}

extension CheckSkillViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = skillList.count
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckSkillTableViewCell", for: indexPath) as! CheckSkillTableViewCell
        cell.skillName.text = skillList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension CheckSkillViewController {
    func setUpLayout() {
        let height = self.navigationController?.navigationBar.bounds.height
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let safePadding = window?.safeAreaInsets.top
        let heightPadding = CGFloat(height!) + CGFloat(safePadding!)
        
        skillListTableView = UITableView()
        view.addSubview(skillListTableView)
        skillListTableView.separatorStyle = .none
        skillListTableView.backgroundColor = .white
        skillListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        lineImg = UIImageView()
        view.addSubview(lineImg)
        lineImg.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationController?.navigationBar.addSubview(saveBtn)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        lineImg.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        lineImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lineImg.widthAnchor.constraint(equalToConstant: 12).isActive = true
        lineImg.topAnchor.constraint(equalTo: view.topAnchor, constant: heightPadding).isActive = true
        lineImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        skillListTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: heightPadding).isActive = true
        skillListTableView.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 0).isActive = true
        skillListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        skillListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        skillListTableView.register(CheckSkillTableViewCell.self, forCellReuseIdentifier: "CheckSkillTableViewCell")
        skillListTableView.delegate = self
        skillListTableView.dataSource = self
        
        saveBtn.trailingAnchor.constraint(equalTo: self.navigationController?.navigationBar.trailingAnchor ?? self.view.trailingAnchor, constant: -12).isActive = true
        saveBtn.bottomAnchor.constraint(equalTo: self.navigationController?.navigationBar.bottomAnchor ?? view.topAnchor, constant: -16).isActive = true
        saveBtn.widthAnchor.constraint(equalToConstant: 26).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: 26).isActive = true
        saveBtn.image = UIImage(named: "check")
        saveBtn.layer.cornerRadius = 12
        saveBtn.clipsToBounds = true
        
        let saveBtnGesture = UITapGestureRecognizer(target: self, action: #selector(saveSkill))
        saveBtn.addGestureRecognizer(saveBtnGesture)
        saveBtn.isUserInteractionEnabled = true
    }
}
