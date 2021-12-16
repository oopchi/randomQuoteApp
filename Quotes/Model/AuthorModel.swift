//
//  AuthorModel.swift
//  Quotes
//
//  Created by Calvin Alfrido on 16/12/21.
//

import Foundation

class Author: Decodable {
    var authors: [AuthorMember]
}

class AuthorMember: Decodable {
    var name: String
}
