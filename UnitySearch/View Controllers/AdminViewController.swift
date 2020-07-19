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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Admin"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
    }
}
