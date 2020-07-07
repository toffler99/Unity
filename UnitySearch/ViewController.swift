//
//  ViewController.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/2/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
        Utilitites.styleFilledButton(signUpButton)
        Utilitites.styleHollowButton(loginButton)
    }

}

