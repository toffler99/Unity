//
//  ViewController.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/2/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var signUpButton: UIButton!
    private var loginButton: UIButton!
    private var recruiterButton: UIButton!
    
    private var unityTitle : UIImageView!
    private var lineImg : UIImageView!
    private var featureViewA : UIView!
    private var techExperLabel : UILabel!
    private var featuerViewB : UIView!
    private var expanNetLabel : UILabel!
    private var featuerViewC : UIView!
    private var personalLabel : UILabel!
    private var containerView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setUpElements()
        signUpButton.addTarget(self, action: #selector(ViewController.presentSignUpVC(sender:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(presentLoginVC(sender:)), for: .touchUpInside)
        recruiterButton.addTarget(self, action: #selector(presentRecuiterVC(sender:)), for: .touchUpInside)
    }
    
    func setUpElements() {
        lineImg = UIImageView()
        unityTitle = UIImageView()
        featureViewA = UIView()
        featuerViewB = UIView()
        featuerViewC = UIView()
        techExperLabel = UILabel()
        expanNetLabel = UILabel()
        personalLabel = UILabel()
        containerView = UIImageView()
        signUpButton = UIButton()
        loginButton = UIButton()
        recruiterButton = UIButton()
        
        view.addSubview(lineImg)
        view.addSubview(unityTitle)
        view.addSubview(featureViewA)
        view.addSubview(featuerViewB)
        view.addSubview(featuerViewC)
        featureViewA.addSubview(techExperLabel)
        featuerViewB.addSubview(expanNetLabel)
        featuerViewC.addSubview(personalLabel)
        view.addSubview(containerView)
        containerView.addSubview(signUpButton)
        containerView.addSubview(loginButton)
        containerView.addSubview(recruiterButton)
        
        lineImg.translatesAutoresizingMaskIntoConstraints = false
        unityTitle.translatesAutoresizingMaskIntoConstraints = false
        featureViewA.translatesAutoresizingMaskIntoConstraints = false
        featuerViewB.translatesAutoresizingMaskIntoConstraints = false
        featuerViewC.translatesAutoresizingMaskIntoConstraints = false
        techExperLabel.translatesAutoresizingMaskIntoConstraints = false
        expanNetLabel.translatesAutoresizingMaskIntoConstraints = false
        personalLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        recruiterButton.translatesAutoresizingMaskIntoConstraints = false
        
        lineImg.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        lineImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lineImg.widthAnchor.constraint(equalToConstant: 12).isActive = true
        lineImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lineImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        unityTitle.backgroundColor = .clear
        unityTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        unityTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.frame.size.height * 0.2)).isActive = true
        unityTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        unityTitle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18).isActive = true
        unityTitle.image = UIImage(named: "UnityLogoUpdated")
        
        featureViewA.topAnchor.constraint(equalTo: unityTitle.bottomAnchor, constant: 12).isActive = true
        featureViewA.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        featureViewA.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        featureViewA.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12).isActive = true
        Utilitites.addTopBorder(with: featureViewA, with: #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), andWidth: 4)
        
        techExperLabel.topAnchor.constraint(equalTo: featureViewA.topAnchor, constant: 4).isActive = true
        techExperLabel.leadingAnchor.constraint(equalTo: featureViewA.leadingAnchor, constant: 0).isActive = true
        techExperLabel.trailingAnchor.constraint(equalTo: featureViewA.trailingAnchor, constant: 0).isActive = true
        techExperLabel.bottomAnchor.constraint(equalTo: featureViewA.bottomAnchor, constant: 0).isActive = true
        techExperLabel.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        techExperLabel.text = "TECHNICAL EXPERTISE"
        techExperLabel.textAlignment = .center
        techExperLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        techExperLabel.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        
        featuerViewB.topAnchor.constraint(equalTo: featureViewA.bottomAnchor, constant: 0).isActive = true
        featuerViewB.leadingAnchor.constraint(equalTo: featureViewA.leadingAnchor, constant: 0).isActive = true
        featuerViewB.trailingAnchor.constraint(equalTo: featureViewA.trailingAnchor, constant: 0).isActive = true
        featuerViewB.heightAnchor.constraint(equalTo: featureViewA.heightAnchor, multiplier: 1).isActive = true
        Utilitites.addTopBorder(with: featuerViewB, with: #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), andWidth: 4)
        
        expanNetLabel.topAnchor.constraint(equalTo: featuerViewB.topAnchor, constant: 4).isActive = true
        expanNetLabel.leadingAnchor.constraint(equalTo: featuerViewB.leadingAnchor, constant: 0).isActive = true
        expanNetLabel.trailingAnchor.constraint(equalTo: featuerViewB.trailingAnchor, constant: 0).isActive = true
        expanNetLabel.bottomAnchor.constraint(equalTo: featuerViewB.bottomAnchor, constant: 0).isActive = true
        expanNetLabel.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        expanNetLabel.text = "EXPANSIVE NETWORK"
        expanNetLabel.textAlignment = .center
        expanNetLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        expanNetLabel.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        
        featuerViewC.topAnchor.constraint(equalTo: featuerViewB.bottomAnchor, constant: 0).isActive = true
        featuerViewC.leadingAnchor.constraint(equalTo: featureViewA.leadingAnchor, constant: 0).isActive = true
        featuerViewC.trailingAnchor.constraint(equalTo: featureViewA.trailingAnchor, constant: 0).isActive = true
        featuerViewC.heightAnchor.constraint(equalTo: featureViewA.heightAnchor, multiplier: 1).isActive = true
        Utilitites.addTopBorder(with: featuerViewC, with: #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), andWidth: 4)
        
        personalLabel.topAnchor.constraint(equalTo: featuerViewC.topAnchor, constant: 4).isActive = true
        personalLabel.leadingAnchor.constraint(equalTo: featuerViewC.leadingAnchor, constant: 0).isActive = true
        personalLabel.trailingAnchor.constraint(equalTo: featuerViewC.trailingAnchor, constant: 0).isActive = true
        personalLabel.bottomAnchor.constraint(equalTo: featuerViewC.bottomAnchor, constant: 0).isActive = true
        personalLabel.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        personalLabel.text = "PERSONALIZED ATTENTION"
        personalLabel.textAlignment = .center
        personalLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        personalLabel.textColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: lineImg.trailingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        containerView.backgroundColor = #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)
        containerView.isUserInteractionEnabled = true
    
        signUpButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -4).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel!.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        signUpButton.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        signUpButton.setTitleColor(.white, for: .normal)
        
        loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 6).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -4).isActive = true
        loginButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel!.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        loginButton.setTitleColor(.white, for: .normal)
        
        recruiterButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 6).isActive = true
        recruiterButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -4).isActive = true
        recruiterButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6).isActive = true
        recruiterButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        recruiterButton.setTitle("Recuiter", for: .normal)
        recruiterButton.titleLabel!.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        recruiterButton.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        recruiterButton.setTitleColor(#colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1), for: .normal)
        
    }

    @objc func presentSignUpVC(sender : UIButton) {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func presentLoginVC(sender : UIButton) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func presentRecuiterVC(sender : UIButton) {
        let recruiterVC = RecruiterLoginViewController()
        self.navigationController?.pushViewController(recruiterVC, animated: true)
    }
}

