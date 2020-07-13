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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    var goBackBtn : UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Login"
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = .white
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        setNavigationBackButton(onView: self, in: goBackBtn, bool: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigationBackButton(onView: self, in: goBackBtn, bool: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    func setUpElements() {
        //Hide error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilitites.styleTextField(emailTextField)
        Utilitites.styleTextField(passwordTextField)
        Utilitites.styleFilledButton(loginButton)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LogInButtonTapped(_ sender: Any) {
        
        // Validate textfields
        pushProfileVC()
        
//        // Create cleaned versions of textfields
//        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        // Sign in the user
//        Auth.auth().signIn(withEmail: cleanedEmail, password: cleanedPassword) { (result, error) in
//            if error != nil {
//                // Could not sign in
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
//            } else {
//                self.pushProfileVC()
//            }
//        }
        
    }
    
    func transitionToHome() {
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
    
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func pushProfileVC() {
        let profileVC = ProfileViewConroller()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
