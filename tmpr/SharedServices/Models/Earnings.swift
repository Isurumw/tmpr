//
//  Earnings.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class Earnings: Codable, Equatable {
    var currency: String?
    var amount: Double?
    
    init(currency: String?, amount: Double?) {
        self.currency = currency
        self.amount = amount
    }
    
    static func == (lhs: Earnings, rhs: Earnings) -> Bool {
        return lhs.currency == rhs.currency && lhs.amount == rhs.amount
    }
    
    enum CodingKeys: String, CodingKey {
        case currency
        case amount
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
    }

}
