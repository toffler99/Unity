//
//  ProfileViewController.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/09.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import GDCheckbox

class ProfileViewConroller : UIViewController, SelectSkillDelegate {
    

    //property
    //first name, last name, email, phoneNum, status, skill
    private var NameLB : UILabel!
    private var firstNameTF : UITextField!
    private var lastNameTF : UITextField!
    private var emailLB : UILabel!
    private var emailTF : UITextField!
    private var phoneNumLB : UILabel!
    private var phoneNumTF : UITextField!
    private var saveBtn : UILabel!
    private var editBtn : UIImageView!
    private var statusLB : UILabel!
    private var skillList : [String] = ["aaaaaaaa","bbbbbbbbbbbbb"]
    private var skillLB : UILabel!
    private var statusSwitch : UISwitch!
    private var checkBtn : UIImageView!
    private var goBackBtn : UIImageView = UIImageView()
    private var lineImg : UIImageView!
    private var skillTableView : UITableView!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBackButton(onView: self, in: goBackBtn, bool: true)
        addSubView()
        setUpLayout()
        addGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: goBackBtn, bool: false)
    }
    
    @objc func tuchUpInsideCheckBtn() {
        print("tap CheckBtn")
        let checkSkillVC = CheckSkillViewController()
        checkSkillVC.selectSkillDelegate = self
        navigationController?.pushViewController(checkSkillVC, animated: true)
    }
    
    func selectSkillDelegate(skillList: [String]) {
        self.skillList = skillList
        skillTableView.reloadData()
        print("skill List \(skillList)")
    }
}

extension ProfileViewConroller {
    func addSubView() {
        NameLB = UILabel()
        firstNameTF = UITextField()
        lastNameTF = UITextField()
        emailLB = UILabel()
        emailTF = UITextField()
        phoneNumLB = UILabel()
        phoneNumTF = UITextField()
        saveBtn = UILabel()
        editBtn = UIImageView()
        lineImg = UIImageView()
        statusLB = UILabel()
        statusSwitch = UISwitch()
        checkBtn = UIImageView()
        skillLB = UILabel()
        skillTableView = UITableView()
        
        NameLB.translatesAutoresizingMaskIntoConstraints = false
        firstNameTF.translatesAutoresizingMaskIntoConstraints = false
        lastNameTF.translatesAutoresizingMaskIntoConstraints = false
        emailLB.translatesAutoresizingMaskIntoConstraints = false
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        phoneNumLB.translatesAutoresizingMaskIntoConstraints = false
        phoneNumTF.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        editBtn.translatesAutoresizingMaskIntoConstraints = false
        lineImg.translatesAutoresizingMaskIntoConstraints = false
        statusLB.translatesAutoresizingMaskIntoConstraints = false
        statusSwitch.translatesAutoresizingMaskIntoConstraints = false
        checkBtn.translatesAutoresizingMaskIntoConstraints = false
        skillLB.translatesAutoresizingMaskIntoConstraints = false
        skillTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(NameLB)
        view.addSubview(firstNameTF)
        view.addSubview(lastNameTF)
        view.addSubview(emailLB)
        view.addSubview(emailTF)
        view.addSubview(phoneNumLB)
        view.addSubview(phoneNumTF)
        view.addSubview(saveBtn)
        view.addSubview(editBtn)
        view.addSubview(lineImg)
        view.addSubview(statusLB)
        view.addSubview(statusSwitch)
        view.addSubview(checkBtn)
        view.addSubview(skillLB)
        view.addSubview(skillTableView)
    }
    
    func setUpLayout() {
        let height = self.navigationController?.navigationBar.bounds.height
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let safePadding = window?.safeAreaInsets.top
        let heightPadding = CGFloat(height!) + CGFloat(safePadding!)
        let nameLbPadding = heightPadding + CGFloat(12)
        
        lineImg.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        lineImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lineImg.widthAnchor.constraint(equalToConstant: 12).isActive = true
        lineImg.topAnchor.constraint(equalTo: view.topAnchor, constant: heightPadding).isActive = true
        lineImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        NameLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        NameLB.topAnchor.constraint(equalTo: view.topAnchor, constant: nameLbPadding).isActive = true
        NameLB.widthAnchor.constraint(equalToConstant: 16).isActive = true
        NameLB.heightAnchor.constraint(equalToConstant: 32).isActive = true
        NameLB.text = "n:"
        NameLB.textAlignment = .left
        
        firstNameTF.leadingAnchor.constraint(equalTo: NameLB.trailingAnchor, constant: 4).isActive = true
        firstNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: nameLbPadding).isActive = true
        firstNameTF.heightAnchor.constraint(equalToConstant: 32).isActive = true
        firstNameTF.adjustsFontSizeToFitWidth = true
        firstNameTF.allowsEditingTextAttributes = false
        firstNameTF.text = "firstName"
        
        lastNameTF.leadingAnchor.constraint(equalTo: firstNameTF.trailingAnchor, constant: 4).isActive = true
        lastNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: nameLbPadding).isActive = true
        lastNameTF.heightAnchor.constraint(equalToConstant: 32).isActive = true
        lastNameTF.adjustsFontSizeToFitWidth = true
        lastNameTF.allowsEditingTextAttributes = false
        lastNameTF.text = "lastName"
        
        phoneNumLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        phoneNumLB.topAnchor.constraint(equalTo: NameLB.bottomAnchor, constant: 12).isActive = true
        phoneNumLB.widthAnchor.constraint(equalToConstant: 12).isActive = true
        phoneNumLB.heightAnchor.constraint(equalToConstant: 32).isActive = true
        phoneNumLB.text = "p:"
        phoneNumLB.textAlignment = .left
        
        phoneNumTF.leadingAnchor.constraint(equalTo: phoneNumLB.trailingAnchor, constant: 4).isActive = true
        phoneNumTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 12).isActive = true
        phoneNumTF.widthAnchor.constraint(equalToConstant: 200).isActive = true
        phoneNumTF.heightAnchor.constraint(equalToConstant: 32).isActive = true
        phoneNumTF.allowsEditingTextAttributes = false
        phoneNumTF.text = "010 1234 5678"
        
        emailLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        emailLB.topAnchor.constraint(equalTo: phoneNumLB.bottomAnchor, constant: 12).isActive = true
        emailLB.widthAnchor.constraint(equalToConstant: 12).isActive = true
        emailLB.heightAnchor.constraint(equalToConstant: 32).isActive = true
        emailLB.text = "e:"
        emailLB.textAlignment = .left
        
        emailTF.leadingAnchor.constraint(equalTo: emailLB.trailingAnchor, constant: 4).isActive = true
        emailTF.topAnchor.constraint(equalTo: phoneNumTF.bottomAnchor, constant: 12).isActive = true
        emailTF.widthAnchor.constraint(equalToConstant: 240).isActive = true
        emailTF.heightAnchor.constraint(equalToConstant: 32).isActive = true
        emailTF.allowsEditingTextAttributes = false
        emailTF.text = "toffler@google.com"
        
        statusLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        statusLB.topAnchor.constraint(equalTo: emailLB.bottomAnchor, constant: 12).isActive = true
        statusLB.heightAnchor.constraint(equalToConstant: 32).isActive = true
        statusLB.widthAnchor.constraint(equalToConstant: 200).isActive = true
        statusLB.text = "looking for a job"
        statusLB.backgroundColor = .yellow
        statusLB.textAlignment = .left
        
        statusSwitch.topAnchor.constraint(equalTo: statusLB.topAnchor, constant: 0).isActive = true
        statusSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        statusSwitch.heightAnchor.constraint(equalToConstant: 12).isActive = true
        statusSwitch.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        skillLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        skillLB.topAnchor.constraint(equalTo: statusLB.bottomAnchor, constant: 12).isActive = true
        skillLB.heightAnchor.constraint(equalToConstant: 32).isActive = true
        skillLB.widthAnchor.constraint(equalToConstant: 56).isActive = true
        skillLB.text = "skill"
        skillLB.textAlignment = .left
        
        checkBtn.centerYAnchor.constraint(equalTo: skillLB.centerYAnchor, constant: 0).isActive = true
        checkBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        checkBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkBtn.image = UIImage(named: "rightarrow")
        
        skillTableView.separatorStyle = .none
        skillTableView.backgroundColor = .yellow
        skillTableView.topAnchor.constraint(equalTo: skillLB.bottomAnchor, constant: 8).isActive = true
        skillTableView.leadingAnchor.constraint(equalTo: skillLB.leadingAnchor, constant: 12).isActive = true
        skillTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        skillTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        skillTableView.delegate = self
        skillTableView.dataSource = self
        skillTableView.register(ProfileSkillTableViewCell.self, forCellReuseIdentifier: "ProfileSkillTableViewCell")
    }
    
    func addGesture() {
        let checkBtnGesture = UITapGestureRecognizer(target: self, action: #selector(tuchUpInsideCheckBtn))
        checkBtn.addGestureRecognizer(checkBtnGesture)
        checkBtn.isUserInteractionEnabled = true
    }
}

extension ProfileViewConroller : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}

extension ProfileViewConroller : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(skillList.count)
        return self.skillList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSkillTableViewCell", for: indexPath) as! ProfileSkillTableViewCell
        cell.skillName.text = skillList[indexPath.row]
        cell.skillName.textColor = .black
        return cell
    }
    
    
}
