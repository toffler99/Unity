//
//  User.swift
//  UnitySearch
//
//  Created by Dongwoo Pae on 7/15/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var id: String
    var status: Bool?  //we are directly fetching this from firebase no local at this moment
    var skills: [String]? //we are directly fetching this from firebase no local at this moment
}
