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
    
    
    @IBOutlet weak var elementsStackView: UIStackView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var userController = UserController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Style the elements
        
        elementsStackView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        elementsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        elementsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        elementsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        firstNameTextField.backgroundColor = .yellow
        firstNameTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 1).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -1).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        lastNameTextField.backgroundColor = .yellow
        lastNameTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 1).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -1).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        emailTextField.backgroundColor = .yellow
        emailTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 1).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -1).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        phoneNumberTextField.backgroundColor = .yellow
        phoneNumberTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 1).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -1).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        passwordTextField.backgroundColor = .yellow
        passwordTextField.leadingAnchor.constraint(equalTo: elementsStackView.leadingAnchor, constant: 1).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: elementsStackView.trailingAnchor, constant: -1).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
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
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
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


