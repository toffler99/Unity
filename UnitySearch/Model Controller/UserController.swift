//
//  UserController.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/15/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation

class UserController {
    
    var user: User?
    
    init() {reloadFromPersistentStore()}
    
    
    func createUser(firstName: String, lastName: String, email: String, phoneNumber: String, id: String) {
        let myProfile = User(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, id: id)
        self.user = myProfile
        saveToPersistentStore()
    }
    
    //update for local
    
    //Basic Persistence//
    //create a file
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    //save it to location(file)
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let userData = try encoder.encode(user)
            try userData.write(to: url)
        } catch {
            NSLog("error saving user data: \(error)")
        }
    }
    
    
    //reload it from location (file)
    func reloadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeUser = try decoder.decode(User.self, from: data)
            self.user = decodeUser
        } catch {
            NSLog("error loading user Profile data:\(error)")
        }
    }
}
