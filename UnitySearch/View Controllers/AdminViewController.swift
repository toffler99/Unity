//
//  AdminViewController.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/19.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class AdminViewController : UIViewController {
    
    //property
    var backBtn : UIImageView = UIImageView()
    var sendButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Admin"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.005039108917, green: 0.2046912909, blue: 0.4367187917, alpha: 1)]
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        
        self.setUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
    }
    
    private func setUpButton() {
        self.view.addSubview(sendButton)
    
        sendButton.backgroundColor = UIColor.orange
        sendButton.tintColor = UIColor.white
        sendButton.setTitle("Send Report", for: .normal)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        sendButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        sendButton.isUserInteractionEnabled = true
        sendButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton) {
        print("button clicked!!!")
        
        
        //add json into excel file (csv) and send it to recruiter's email
        
        
        
        
        //add alert to tell the user that the report has been sent to the email
        
        
        
        
    }
    
    
    
}
