//
//  AdminViewController.swift
//  UnitySearch
//
//  Created by ilhan won on 2020/07/19.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

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
        Utilitites.shake(sendButton)
        
        //add json into excel file (csv) and send it to recruiter's email
        
        
        
        
        //add alert to tell the user that the report has been sent to the email
        
        self.showMailComposer()
    }
    
    //MARK: Email Compose
    private func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            self.showNoEmailAlert()
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["recruiter's email"])
        composer.setSubject("Candidate Report")
        
        //fetch firebase files (json)
        
        
        //convert it into cvs file format
        
        
        
        //save this cvs file format into plist
        
        
        
        
        //example : getting the file from here or plist
        guard let filePath = Bundle.main.path(forResource: "filename", ofType: "cvs") else {return}
        let url = URL(fileURLWithPath: filePath)
        
        do {
            let attachmentData = try Data(contentsOf: url)
            //add attachment here
            composer.addAttachmentData(attachmentData, mimeType: "application/cvs", fileName: "filename")
            self.present(composer, animated: true, completion: nil)
        } catch let error {
            print("error in getting data from url:\(url):\(error.localizedDescription)")
        }

    }
    
}

extension AdminViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed to send")
        case .saved:
            print("saved")
        case .sent:
            print("email sent")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showEmailSentAlert()
            }
        default:
            print("default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func showEmailSentAlert() {
        let alert = UIAlertController(title: "Email Sent", message: "Enjoy the report", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
    
    private func showNoEmailAlert() {
        let alert = UIAlertController(title: "No Email View Available", message: "Please set your email view available", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
