//
//  LoginViewController.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/6/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var containerView : UIView!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var errorLabel: UILabel!
    private var loginButton: UIButton!
    
    private var lineImg : UIImageView!
    var goBackBtn : UIImageView = UIImageView()
    
    var userController = UserController()
    private var keyboardShown : Bool = false
    private var originY : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)]
        self.navigationItem.title = "Login"
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = .white
        setUpElements()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        setNavigationBackButton(onView: self, in: goBackBtn, bool: true)
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: goBackBtn, bool: false)
        unregisterForKeyboardNotification()
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpElements() {
        
        lineImg = UIImageView()
        containerView = UIView()
        emailTextField = UITextField()
        passwordTextField = UITextField()
        errorLabel = UILabel()
        loginButton = UIButton()
        
        view.addSubview(lineImg)
        view.addSubview(containerView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(errorLabel)
        containerView.addSubview(loginButton)
        
        lineImg.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
    
    }
    
    func setUpLayout() {
//        let height = self.navigationController?.navigationBar.bounds.height
//        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//        let safePadding = window?.safeAreaInsets.top
//        let heightPadding = CGFloat(height!) + CGFloat(safePadding!)
        
        lineImg.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        lineImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lineImg.widthAnchor.constraint(equalToConstant: 12).isActive = true
        lineImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lineImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        containerView.backgroundColor = .clear
        containerView.isUserInteractionEnabled = true
        
        emailTextField.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.centerYAnchor, constant: 0).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        emailTextField.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        emailTextField.placeholder = "email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .done
        emailTextField.delegate = self
        Utilitites.addBottomBorder(with: emailTextField, with: .lightGray, andWidth: 1)
        
        passwordTextField.topAnchor.constraint(greaterThanOrEqualTo: emailTextField.bottomAnchor, constant: 4).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        passwordTextField.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        passwordTextField.placeholder = "password"
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        Utilitites.addBottomBorder(with: passwordTextField, with: .lightGray, andWidth: 1)
        
        errorLabel.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor, constant: 4).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 72).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        errorLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        errorLabel.textAlignment = .center
        errorLabel.textColor = .red
        errorLabel.adjustsFontForContentSizeCategory = true
        errorLabel.alpha = 0
        
        loginButton.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: -4).isActive = true
        loginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel!.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        loginButton.setTitleColor(#colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1), for: .normal)
        loginButton.addTarget(self, action: #selector(LoginViewController.LogInButtonTapped(_:)), for: .touchUpInside)
        

        emailTextField.text = "toffler00@gmail.com"
        passwordTextField.text = "spoon1532!"
        // Style the elements
    }
    
    @IBAction func LogInButtonTapped(_ sender: Any) {
        
        // Validate textfields
        // pushProfileVC()
        // Create cleaned versions of textfields
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        // Sign in the user
        Auth.auth().signIn(withEmail: cleanedEmail, password: cleanedPassword) { (result, error) in
            if error != nil {
                // Could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let uid = result?.user.uid
                switch uid {
                case "jRkJgeiZQvS7cTgJWqYj4FlBVJG3":
                    self.pushAdminVC()
                default:
                    self.pushProfileVC()
                }
            }
        }
    }
    
    func pushProfileVC() {
        let profileVC = ProfileViewConroller()
        guard let user = self.userController.user else {return}
        profileVC.user = user
        profileVC.userController = userController
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func pushAdminVC() {
        let adminVC = AdminViewController()
        navigationController?.pushViewController(adminVC, animated: true)
    }
}


extension LoginViewController {
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
                print(keyboardSize.height)
                  return
              }
                UIView.animate(withDuration: 0.33, animations: {
                    guard let originY = self.originY else { return }
                    self.containerView.translatesAutoresizingMaskIntoConstraints = false
                    self.containerView.frame.origin.y = originY
    //                self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
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
                    if self.originY == nil { self.originY = self.containerView.frame.origin.y }
                    let height = self.containerView.frame.size.height / 2
                    self.containerView.frame.origin.y = self.originY! - height
                    self.containerView.translatesAutoresizingMaskIntoConstraints = true
                }) { (Bool) in
                    self.keyboardShown = true
                }
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
