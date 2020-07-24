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
import Firebase

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
        
        //it takes value of each key for each user so just create csv format using those values with column headers and save them into csv file (filemanager) when you fetch the firebase data
        let db = Firestore.firestore()
        
        let docRef = db.collection("users")
        docRef.getDocuments { (snapshot, error) in
            if let error = error {
                debugPrint("Error fetching docs: \(error)")
            } else {
                guard let snap = snapshot else {return}
                for document in snap.documents {
                    let data = document.data()
                    self.createCSVX(from: data)
                }
            }
        }
        
        //add alert to tell the user that the report has been sent through email if it is sent successfully
        
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
        
        //example : getting the file from here or plist -> get cvs file from file manager - basic persistenc store -> you will need data format to be able to include into an email attachment
        /*
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
 */

    }
    
    private func createCSVX(from recArray:[String: Any]) {
        //func for converting [String: Any] into csv format
        var heading = "FirstName, LastName\n"
        //let rows = recArray.map {"\($0["T"]!),\($0["F"]!)"}
        
        
        
        //save it into file manager
        //let csvString = heading + rows.joined(separator: "\n")
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            let fileURL = path.appendingPathComponent("CandidateReport.csv")
            
           // try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("error creating file")
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
