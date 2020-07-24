//
//  SignUpViewController.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/6/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    
    private var elementsStackView: UIView!
    private var firstNameTextField: CustomTextField!
    private var lastNameTextField: CustomTextField!
    private var phoneNumberTextField: CustomTextField!
    private var emailTextField: CustomTextField!
    private var passwordTextField: CustomTextField!
    private var signUpButton: UIButton!
    private var errorLabel: UILabel!
    private var headingText : UILabel!
    private var mainTextView : UITextView!
    private var backBtn : UIImageView = UIImageView()
    private var lineImg : UIImageView!
    
    var userController = UserController()
    fileprivate var elementsStackViewRect : CGRect!
    fileprivate var keyboardShown : Bool = false
    fileprivate var originY : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "WHY UNITY"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)]
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: backBtn, bool: true)
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: backBtn, bool: false)
        unregisterForKeyboardNotification()
    }
    
    func setUpElements() {
        let height = self.navigationController?.navigationBar.bounds.height
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let safePadding = window?.safeAreaInsets.top
        let heightPadding = CGFloat(height!) + CGFloat(safePadding!)
        
        // Style the elements
        lineImg = UIImageView()
        headingText = UILabel()
        mainTextView = UITextView()
        elementsStackView = UIView()
        firstNameTextField = CustomTextField()
        lastNameTextField = CustomTextField()
        phoneNumberTextField = CustomTextField()
        emailTextField = CustomTextField()
        passwordTextField = CustomTextField()
        errorLabel = UILabel()
        signUpButton = UIButton()
         
        view.addSubview(lineImg)
        lineImg.translatesAutoresizingMaskIntoConstraints = false
        lineImg.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        lineImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lineImg.widthAnchor.constraint(equalToConstant: 12).isActive = true
        lineImg.topAnchor.constraint(equalTo: view.topAnchor, constant: heightPadding).isActive = true
        lineImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(headingText)
        headingText.translatesAutoresizingMaskIntoConstraints = false
        headingText.topAnchor.constraint(equalTo: view.topAnchor, constant: heightPadding).isActive = true
        headingText.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 8).isActive = true
        headingText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        headingText.heightAnchor.constraint(equalToConstant: 28).isActive = true
        headingText.text = "Success begins with Unity"
        headingText.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        headingText.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        view.addSubview(mainTextView)
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        mainTextView.topAnchor.constraint(equalTo: headingText.bottomAnchor, constant: 2).isActive = true
        mainTextView.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 8).isActive = true
        mainTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mainTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        mainTextView.textAlignment = .left
        mainTextView.adjustsFontForContentSizeCategory = true
        mainTextView.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        mainTextView.backgroundColor = .white
        mainTextView.textAlignment = .left
        mainTextView.isUserInteractionEnabled = false
        mainTextView.isScrollEnabled = false
        mainTextView.text = "Unity was founded in 2010 with one goal in mind: to create long-term partnerships for accounting and finance professionals by focusing on the needs and aspirations of the individual who matters most… you. \n\nToday, each one of Unity’s dedicated team members continues to provide an unparalleled level of service through expertise, commitment, trust and a diverse network. Each Unity employee truly listens to understand your needs as either a hiring manager or candidate, and is able to provide informed recommendations and advice. At Unity we view ourselves as more than your recruiter, we view ourselves as your consultant."
        
        view.addSubview(elementsStackView)
        elementsStackView.translatesAutoresizingMaskIntoConstraints = false
        elementsStackView.topAnchor.constraint(equalTo: mainTextView.bottomAnchor, constant: 4).isActive = true
        elementsStackView.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 0).isActive = true
        elementsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        elementsStackView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        elementsStackView.backgroundColor = .white
        addTopBorder(with: elementsStackView, with: #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), andWidth: 2)
        addBottomBorder(with: elementsStackView, with: #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), andWidth: 2)
        
        elementsStackView.addSubview(firstNameTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.backgroundColor = .green
        firstNameTextField.topAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: 2).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 4).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: elementsStackView.widthAnchor, multiplier: 0.48).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        firstNameTextField.placeholder = "first name"

        elementsStackView.addSubview(lastNameTextField)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.backgroundColor = .yellow
        lastNameTextField.topAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: 2).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -4).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: elementsStackView.widthAnchor, multiplier: 0.49).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lastNameTextField.placeholder = "last name"

        elementsStackView.addSubview(phoneNumberTextField)
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.backgroundColor = .white
        phoneNumberTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 4).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 4).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -4).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        phoneNumberTextField.placeholder = "phone number"

        elementsStackView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.backgroundColor = .white
        emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 4).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 4).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -4).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        emailTextField.placeholder = "email"

        elementsStackView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .white
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 4).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -4).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        passwordTextField.placeholder = "password"

        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 4).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.setTitle("Confirm", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpTapped(_:)), for: .touchUpInside)

        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 4).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 4).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        errorLabel.backgroundColor = .clear
        errorLabel.alpha = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = .red
        errorLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)

        Utilitites.styleTextField(firstNameTextField)
        Utilitites.styleTextField(lastNameTextField)
        Utilitites.styleTextField(emailTextField)
        Utilitites.styleTextField(phoneNumberTextField)
        Utilitites.styleTextField(passwordTextField)
        Utilitites.styleFilledButton(signUpButton)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilitites.isPasswordValid(cleanedPassword) == false {
            // Password is not secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    
    func addTopBorder(with view : UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }
    
    func addBottomBorder(with view: UIView,with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - borderWidth, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }

    func addLeftBorder(with view: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: view.frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        view.addSubview(border)
    }

    func addRightBorder(with view: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: view.frame.size.width - borderWidth, y: 0, width: borderWidth, height: view.frame.size.height)
        view.addSubview(border)
    }
    
    @objc func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There is something wrong with the fields, show error message
            showError(error!)
        } else {
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
    
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                // Check for errors
                if error != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    let newUser = db.collection("users").document()
                    
                    let documentID = newUser.documentID
                    
                    newUser.setData(["firstName" : firstName, "lastName": lastName, "phoneNumber": phoneNumber, "email": email ,"timeStamp": Date(), "id": documentID])
                    
                    //Creating local data
                    self.userController.createUser(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: documentID)
                    
                    
                    // Save documentID into userDefault -> basic persistence above will save documentID as id
                    //UserDefaults.standard.set(documentID, forKey: "myID")
                    
                    // to profile VC
                    self.pushProfileVC()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
//    func transitionToHome() {
//        let homeViewController =
//        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//
//        view.window?.rootViewController = homeViewController
//        view.window?.makeKeyAndVisible()
//    }'
    
    func pushProfileVC() {
        let profileVC = ProfileViewConroller()
        guard let user = self.userController.user else {return}
        profileVC.user = user
        profileVC.userController = self.userController
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

extension SignUpViewController  {
    
    fileprivate func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keboardFrameWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameDidChange),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    fileprivate func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keboardFrameWillHide(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
          if keyboardShown == false {
              return
          }
            UIView.animate(withDuration: 0.33, animations: {
                guard let originY = self.originY else { return }
                self.elementsStackView.translatesAutoresizingMaskIntoConstraints = false
                self.elementsStackView.frame.origin.y = originY
            }) { (Bool) in
                self.keyboardShown = false
            }
        }
    }
    
    @objc func keyboardFrameDidChange(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height == 0.0 || keyboardShown == true {
                return
            }
            UIView.animate(withDuration: 0.33, animations: {
                if self.originY == nil { self.originY = self.elementsStackView.frame.origin.y }
                let height = keyboardSize.height - self.elementsStackView.frame.size.height
                self.elementsStackView.frame.origin.y = self.originY! - height
                self.elementsStackView.translatesAutoresizingMaskIntoConstraints = true
            }) { (Bool) in
                self.keyboardShown = true
            }
        }
    }
}
