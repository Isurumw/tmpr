//
//  Aggregations.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation

class Aggregation: Codable {
    
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }

}
