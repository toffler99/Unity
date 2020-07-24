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
import Firebase
import PhoneNumberKit

class ProfileViewConroller : UIViewController, SelectSkillDelegate, UITextFieldDelegate {
    
    
    //property
    //first name, last name, email, phoneNum, status, skill
    private var nameLB : UILabel!
    private var firstNameTF : CustomTextField!
    private var lastNameTF : CustomTextField!
    private var emailLB : UILabel!
    private var emailTF : CustomTextField!
    private var phoneNumLB : UILabel!
    private var phoneNumTF : UITextField!
    private var saveBtn : UILabel!
    private var editBtn : UIImageView!
    private var statusLB : UILabel!
    private var skillList : [String] = []
    private var skillLB : UILabel!
    private var statusSwitch : UISwitch!
    private var checkBtn : UIImageView!
    private var goBackBtn : UIImageView = UIImageView()
    private var lineImg : UIImageView!
    private var skillTableView : UITableView!
    private var isEditingBtn : UIButton = UIButton()
    private var yLabel : UILabel!
    private var nLabel : UILabel!
    private var skillBackView : UIView!
    
    var user: User?
    var userController: UserController = UserController()
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)]
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBackButton(onView: self, in: goBackBtn, bool: false)
        setEditButton(onView: self, in: isEditingBtn, bool: true)
        if lineImg == nil {
            addSubView()
            setUpLayout()
            addGesture()
            updateViews()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setEditButton(onView: self, in: isEditingBtn, bool: false)
    }
    
    //Updateviews and sync between firebase and local
    private func updateViews() {
        
        //updateviews from local
        guard let user = self.user else {return}
        self.firstNameTF.text = user.firstName
        self.lastNameTF.text = user.lastName
        self.emailTF.text = user.email
        self.phoneNumTF.text = user.phoneNumber
        switch user.status {
        case true:
            statusSwitch.isOn = true
        default:
            statusSwitch.isOn = false
        }
        guard let localSkills = user.skills else {return}
        self.skillList = localSkills
        
        //fetchDatafromFirebase
        //guard let userDefualtID = UserDefaults.standard.object(forKey: "myID") else {return}
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document("\(user.id)")
        docRef.getDocument { (document, error) in
            if error != nil {
                print("there is an error in getting user profile")
            }
            
            if let document = document, document.exists {
                guard let data = document.data() else {return}
                let firstName = data["firstName"] as? String ?? "Anonymous"
                let lastName = data["lastName"] as? String ?? "Anonymous"
                let email = data["email"] as? String ?? ""
                let phoneNumber = data["phoneNumber"] as? String ?? ""
                let skills = data["skills"] as? [String] ?? []
             
             //compare firebase and local store -> there is another way with UserRepresentation (from firebase) and compare this object to local object with comparison codes at once
                if user.firstName != firstName {
                    self.firstNameTF.text = firstName
                    self.userController.user?.firstName = firstName
                    self.userController.saveToPersistentStore()
                }
                
                if user.lastName != lastName {
                    self.lastNameTF.text = lastName
                    self.userController.user?.lastName = lastName
                    self.userController.saveToPersistentStore()
                }
                
                if user.email != email {
                    self.emailTF.text = email
                    self.userController.user?.email = email
                    self.userController.saveToPersistentStore()
                }
                
                if user.phoneNumber != phoneNumber {
                    self.phoneNumTF.text = phoneNumber
                    self.userController.user?.phoneNumber = phoneNumber
                    self.userController.saveToPersistentStore()
                }
                
                if localSkills != skills {
                    self.skillList = skills
                    self.userController.user?.skills? = skills
                    self.userController.saveToPersistentStore()
                }
                //print(data)
                print(skills)
            }
            DispatchQueue.main.async {
                self.skillTableView.reloadData()
            }
        }
    }
    
    @objc func tuchUpInsideCheckBtn() {
        print("tap CheckBtn")
        let checkSkillVC = CheckSkillViewController()
        checkSkillVC.selectSkillDelegate = self
        navigationController?.pushViewController(checkSkillVC, animated: true)
    }
    
    func addSkillListDelegate(skillList: [String]) {
        self.skillList = skillList
    }
    
    func selectSkillDelegate() {
        skillTableView.reloadData()
        print("skill List \(skillList)")
    }
    
    @objc func tapStatusSwitch() {
        let isOn = statusSwitch.isOn
        let db = Firestore.firestore()
        //guard let userDefualtID = UserDefaults.standard.object(forKey: "myID") else {return}
        guard let user = self.userController.user else {return}
        let useridPath = db.collection("users").document("\(user.id)")
        useridPath.updateData(["status" : isOn])
        //adding skills into local
        self.userController.user?.status = isOn
        self.userController.saveToPersistentStore()
    }
    
    func addGesture() {
        let checkBtnGesture = UITapGestureRecognizer(target: self, action: #selector(tuchUpInsideCheckBtn))
        checkBtn.addGestureRecognizer(checkBtnGesture)
        checkBtn.isUserInteractionEnabled = true
        
        isEditingBtn.addTarget(self, action: #selector(editProfile(sender:)), for: .touchUpInside)
    }
    
    @objc func editProfile(sender : UIButton) {
        if sender.isSelected == false{
            sender.setTitle("Save", for: .normal)
            sender.isSelected = true
            firstNameTF.isUserInteractionEnabled = true
            lastNameTF.isUserInteractionEnabled = true
            phoneNumTF.isUserInteractionEnabled = true
            emailTF.isUserInteractionEnabled = true
        } else {
            print("\(sender.isSelected)")
            sender.setTitle("Edit", for: .normal)
            sender.isSelected = false
            firstNameTF.isUserInteractionEnabled = false
            firstNameTF.backgroundColor = .clear
            lastNameTF.isUserInteractionEnabled = false
            phoneNumTF.isUserInteractionEnabled = false
            emailTF.isUserInteractionEnabled = false
            saveProfileData()
        }
    }
    
    func saveProfileData() {
        let firstN = firstNameTF.text ?? ""
        let lastN = lastNameTF.text ?? ""
        let phoneNum = phoneNumTF.text ?? ""
        let email = emailTF.text ?? ""
        let db = Firestore.firestore()
        //guard let userDefualtID = UserDefaults.standard.object(forKey: "myID") else {return}
        guard let user = self.userController.user else {return}
        let useridPath = db.collection("users").document("\(user.id)")
        useridPath.updateData(["firstName" : firstN])
        useridPath.updateData(["lastName" : lastN])
        useridPath.updateData(["phoneNumber" : phoneNum])
        useridPath.updateData(["email" : email])
        //adding skills into local
        self.userController.user?.firstName = firstN
        self.userController.user?.lastName = lastN
        self.userController.user?.phoneNumber = phoneNum
        self.userController.user?.email = email
        self.userController.saveToPersistentStore()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumTF {
            
        }
        return true
    }
    
    
    
}

extension ProfileViewConroller {
    func addSubView() {
        nameLB = UILabel()
        firstNameTF = CustomTextField()
        lastNameTF = CustomTextField()
        emailLB = UILabel()
        emailTF = CustomTextField()
        phoneNumLB = UILabel()
        phoneNumTF = CustomTextField()
        saveBtn = UILabel()
        editBtn = UIImageView()
        lineImg = UIImageView()
        statusLB = UILabel()
        statusSwitch = UISwitch()
        checkBtn = UIImageView()
        skillLB = UILabel()
        skillTableView = UITableView()
        yLabel = UILabel()
        nLabel = UILabel()
        skillBackView = UIView()
        
        nameLB.translatesAutoresizingMaskIntoConstraints = false
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
        yLabel.translatesAutoresizingMaskIntoConstraints = false
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        skillBackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLB)
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
        view.addSubview(skillBackView)
        skillBackView.addSubview(checkBtn)
        skillBackView.addSubview(skillLB)
        view.addSubview(skillTableView)
        view.addSubview(yLabel)
        view.addSubview(nLabel)
        
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
        
        nameLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 1).isActive = true
        nameLB.topAnchor.constraint(equalTo: view.topAnchor, constant: nameLbPadding).isActive = true
        nameLB.widthAnchor.constraint(equalToConstant: 1).isActive = true
        nameLB.heightAnchor.constraint(equalToConstant: 64).isActive = true
        nameLB.textAlignment = .left
        
        firstNameTF.leadingAnchor.constraint(equalTo: nameLB.trailingAnchor, constant: 1).isActive = true
        firstNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: nameLbPadding).isActive = true
        firstNameTF.heightAnchor.constraint(equalToConstant: 64).isActive = true
//        firstNameTF.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        firstNameTF.font = UIFont(name: "SFProDisplay-Bold", size: 42)
        firstNameTF.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        firstNameTF.adjustsFontSizeToFitWidth = true
        firstNameTF.isUserInteractionEnabled = false
        //firstNameTF.text = "firstName"
        
        lastNameTF.leadingAnchor.constraint(equalTo: firstNameTF.trailingAnchor, constant: 0).isActive = true
        lastNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: nameLbPadding).isActive = true
        lastNameTF.heightAnchor.constraint(equalToConstant: 64).isActive = true
        lastNameTF.font = UIFont(name: "SFProDisplay-Bold", size: 42)
        lastNameTF.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        lastNameTF.adjustsFontSizeToFitWidth = true
        lastNameTF.isUserInteractionEnabled = false
        //lastNameTF.text = "lastName"
        
        phoneNumLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        phoneNumLB.topAnchor.constraint(equalTo: nameLB.bottomAnchor, constant: 9).isActive = true
        phoneNumLB.widthAnchor.constraint(equalToConstant: 20).isActive = true
        phoneNumLB.heightAnchor.constraint(equalToConstant: 28).isActive = true
        phoneNumLB.text = "p:"
        phoneNumLB.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        phoneNumLB.textAlignment = .left
        phoneNumLB.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        phoneNumLB.backgroundColor = .clear
        
        phoneNumTF.leadingAnchor.constraint(equalTo: phoneNumLB.trailingAnchor, constant: 2).isActive = true
        phoneNumTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 12).isActive = true
        phoneNumTF.widthAnchor.constraint(equalToConstant: 200).isActive = true
        phoneNumTF.heightAnchor.constraint(equalToConstant: 28).isActive = true
        phoneNumTF.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        phoneNumTF.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        phoneNumTF.isUserInteractionEnabled = false
        //phoneNumTF.text = "010 1234 5678"
        
        emailLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        emailLB.topAnchor.constraint(equalTo: phoneNumLB.bottomAnchor, constant: 5).isActive = true
        emailLB.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailLB.heightAnchor.constraint(equalToConstant: 28).isActive = true
        emailLB.text = "e:"
        emailLB.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        emailLB.textAlignment = .left
        emailLB.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        
        emailTF.leadingAnchor.constraint(equalTo: emailLB.trailingAnchor, constant: 2).isActive = true
        emailTF.topAnchor.constraint(equalTo: phoneNumTF.bottomAnchor, constant: 2).isActive = true
        emailTF.widthAnchor.constraint(equalToConstant: 240).isActive = true
        emailTF.heightAnchor.constraint(equalToConstant: 28).isActive = true
        emailTF.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        emailTF.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        emailTF.isUserInteractionEnabled = false
        //emailTF.text = "toffler@google.com"
        
        statusLB.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        statusLB.topAnchor.constraint(equalTo: emailLB.bottomAnchor, constant: 12).isActive = true
        statusLB.heightAnchor.constraint(equalToConstant: 48).isActive = true
        statusLB.widthAnchor.constraint(equalToConstant: 230).isActive = true
        statusLB.text = "looking for opportunities?"
        statusLB.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        statusLB.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        statusLB.backgroundColor = .clear
        statusLB.textAlignment = .left
        
        yLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        yLabel.bottomAnchor.constraint(equalTo: statusLB.bottomAnchor, constant: 0).isActive = true
        yLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        yLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        yLabel.text = "Y"
        yLabel.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        
        statusSwitch.centerYAnchor.constraint(equalTo: statusLB.centerYAnchor, constant: -4).isActive = true
        statusSwitch.trailingAnchor.constraint(equalTo: yLabel.leadingAnchor, constant: -16).isActive = true
        statusSwitch.heightAnchor.constraint(equalToConstant: 21).isActive = true
        statusSwitch.widthAnchor.constraint(equalToConstant: 42).isActive = true
        statusSwitch.addTarget(self, action: #selector(tapStatusSwitch), for: .touchUpInside)
        
        nLabel.trailingAnchor.constraint(equalTo: statusSwitch.leadingAnchor, constant: -2).isActive = true
        nLabel.bottomAnchor.constraint(equalTo: statusLB.bottomAnchor, constant: 0).isActive = true
        nLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        nLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        nLabel.text = "N"
        nLabel.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        
        skillBackView.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 0).isActive = true
        skillBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        skillBackView.topAnchor.constraint(equalTo: statusLB.bottomAnchor, constant: 6).isActive = true
        skillBackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        skillBackView.backgroundColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        
        skillLB.leadingAnchor.constraint(equalTo: skillBackView.leadingAnchor, constant: 4).isActive = true
        skillLB.topAnchor.constraint(equalTo: skillBackView.topAnchor, constant: 0).isActive = true
        skillLB.bottomAnchor.constraint(equalTo: skillBackView.bottomAnchor, constant: 0).isActive = true
        skillLB.widthAnchor.constraint(equalToConstant: 56).isActive = true
        skillLB.text = "skill"
        skillLB.textColor = .white
        skillLB.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        skillLB.textAlignment = .left
        
        checkBtn.centerYAnchor.constraint(equalTo: skillBackView.centerYAnchor, constant: 0).isActive = true
        checkBtn.trailingAnchor.constraint(equalTo: skillBackView.trailingAnchor, constant: -16).isActive = true
        checkBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        checkBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        checkBtn.image = UIImage(named: "rightarrow_white")
        
        skillTableView.separatorStyle = .none
        skillTableView.backgroundColor = .clear
        skillTableView.topAnchor.constraint(equalTo: skillLB.bottomAnchor, constant: 6).isActive = true
        skillTableView.leadingAnchor.constraint(equalTo: skillLB.leadingAnchor, constant: 12).isActive = true
        skillTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        skillTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        skillTableView.delegate = self
        skillTableView.dataSource = self
        skillTableView.register(ProfileSkillTableViewCell.self, forCellReuseIdentifier: "ProfileSkillTableViewCell")
    }
}

extension ProfileViewConroller : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }
}

extension ProfileViewConroller : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(skillList.count)
        return self.skillList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSkillTableViewCell", for: indexPath) as! ProfileSkillTableViewCell
        switch skillList.count {
        case 0:
            cell.skillName.text = skillList[indexPath.row]
            cell.skillName.textColor = .black
            cell.selectionStyle = .none
            cell.skillName.font = UIFont(name: "SF-Pro-Display-Medium", size: 30)
        default:
            cell.skillName.text = skillList[indexPath.row]
            cell.skillName.textColor = .black
            cell.selectionStyle = .none
            cell.skillName.font = UIFont(name: "SF-Pro-Display-Medium", size: 30)
        }
        return cell
    }
}

