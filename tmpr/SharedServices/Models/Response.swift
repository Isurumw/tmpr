//
//  Response.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation

class Response: Codable {
    
    var data: [Job] = []
    var aggregations: Aggregation?
    
    enum CodingKeys: String, CodingKey {
        case data
        case aggregations
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent([Job].self, forKey: .data) ?? []
        aggregations = try values.decodeIfPresent(Aggregation.self, forKey: .aggregations)
    }

}

