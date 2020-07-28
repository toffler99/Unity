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
    
    var userReps: [UserRep] = []
    
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
        
        // Fetch firebase and append it to userReps above
        let db = Firestore.firestore()
        let docRef = db.collection("users")
        docRef.getDocuments { (snapshot, error) in
            if error != nil {
                print("there is an error in getting all firebase userdata")
            }
            
            for user in (snapshot?.documents)! {
                let data = user.data()
                let firstName = data["firstName"] as? String ?? "Anonymous"
                let lastName = data["lastName"] as? String ?? "Anonymous"
                let email = data["email"] as? String ?? ""
                let phoneNumber = data["phoneNumber"] as? String ?? ""
                let status = data["status"] as? Bool ?? false
                let timeStamp = data["timeStamp"] as? String ?? ""
                let skills = data["skills"] as? [String] ?? []
                
                let userRep = UserRep(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, status: status, timeStamp: timeStamp, skills: skills)
                self.userReps.append(userRep)
            }
            print(self.userReps)
        }
        
        
        
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
        self.createCSV(from: self.userReps)
        self.showMailComposer()
    }
    
    //MARK: Email Compose - bring csv and attach it to email
    private func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            self.showNoEmailAlert()
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["your email"])
        composer.setSubject("Candidate Report")
        
        
        //bring csv and attach it to an email
        let fileManager = FileManager.default
        let fileURL = self.readingListURL
        guard let url = fileURL,
            fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            composer.addAttachmentData(data, mimeType: "application/csv", fileName: "CandidateReport")
            self.present(composer, animated: true, completion: nil)
        } catch let error {
            NSLog("error getting data from url:\(url) and \(error.localizedDescription)")
        }
    }
    
    
    //create a filePath
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("CandidateReport.csv")
    }
    
    //MARK: Convert array of dictionaries into csv format and save it to document directtory above
    //save csv into directory
    private func createCSV (from userReps:[UserRep]) {
        //func for converting [UserRep] into csv format
        var csvString = "FirstName, LastName, Email\n"
        //let rows = recArray.map {"\($0["T"]!),\($0["F"]!)"}
        //let csvString = heading + rows.joined(separator: "\n")
        for userRep in userReps {
            csvString += userRep.firstName + ", " + userRep.lastName + ", " + "\(userRep.email)\n"
        }
        print(csvString)
        
        //save it into file manager
        do {
            guard let fileURL = self.readingListURL else {return}
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
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
/*
test@unitysearch.com
tester123*
*/
