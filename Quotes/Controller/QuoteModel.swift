//
//  QuoteModel.swift
//  Quotes
//
//  Created by Calvin Alfrido on 16/12/21.
//

import Foundation

class Quote: Decodable {
    var quotes: [QuoteMember]
}

class QuoteMember: Decodable {
    var text: String
    var tag: String
}
