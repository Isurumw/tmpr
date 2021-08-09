//
//  ShiftSchedule.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class ShiftSchedule: Codable {
    
    var id: String?
    var startsAt: String?
    var endsAt: String?
    var earningsPerHour: Earnings?
    
    enum CodingKeys: String, CodingKey {
        case id
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case earningsPerHour = "earnings_per_hour"
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        if let date = try values.decodeIfPresent(String.self, forKey: .startsAt) {
            startsAt = date.time
        }
        if let date = try values.decodeIfPresent(String.self, forKey: .endsAt) {
            endsAt = date.time
        }
        earningsPerHour = try values.decodeIfPresent(Earnings.self, forKey: .earningsPerHour)
    }

}
