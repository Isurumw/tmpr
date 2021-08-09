//
//  Address.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class Address: Codable, Equatable {
    var zipCode: String?
    var street: String?
    var city: String?
    var geo: Geo?
    
    init(zipCode: String?, street: String?, city: String?, geo: Geo?) {
        self.zipCode = zipCode
        self.street = street
        self.city = city
        self.geo = geo
    }
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        return
            lhs.zipCode == rhs.zipCode &&
            lhs.street == rhs.street &&
            lhs.city == rhs.city &&
            lhs.geo == rhs.geo
    }
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case street
        case city
        case geo
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        geo = try values.decodeIfPresent(Geo.self, forKey: .geo)
    }

}
