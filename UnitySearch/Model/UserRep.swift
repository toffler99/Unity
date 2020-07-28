//
//  UserRep.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/27/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation

struct UserRep: Codable, Equatable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var status: Bool
    var timeStamp: String
    var skills: [String]
}
