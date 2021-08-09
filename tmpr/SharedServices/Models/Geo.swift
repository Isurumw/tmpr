//
//  Geo.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class Geo: Codable, Equatable {
    var lat: Double?
    var lon: Double?
    
    init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
    
    static func == (lhs: Geo, rhs: Geo) -> Bool {
        return lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
    }

}
