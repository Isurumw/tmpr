//
//  Job.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation

class Job: Codable, Equatable {
    var id: String!
    var status: String?
    var jobDescription: JobDescription?
    var startsAt: Date?
    var endsAt: Date?
    var earningsPerHour: Earnings?
    var distance: Double?
    
    init(id: String, jobDescription: JobDescription?, startsAt: Date?, endsAt: Date?, earningsPerHour: Earnings?, distance: Double?) {
        self.id = id
        self.jobDescription = jobDescription
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.earningsPerHour = earningsPerHour
        self.distance = distance
    }
    
    static func == (lhs: Job, rhs: Job) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.status == rhs.status &&
            lhs.jobDescription == rhs.jobDescription &&
            lhs.startsAt == rhs.startsAt &&
            lhs.endsAt == rhs.endsAt &&
            lhs.earningsPerHour == rhs.earningsPerHour &&
            lhs.distance == rhs.distance
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case earningsPerHour = "earnings_per_hour"
        case jobDescription = "job"
        case recurringShiftSchedule = "recurring_shift_schedule"
        case distance
    }
    
    // Encodable protocol methods
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        
        if let date  = try values.decodeIfPresent(String.self, forKey: .startsAt) {
            startsAt = date.date
        }
        if let date  = try values.decodeIfPresent(String.self, forKey: .endsAt) {
            endsAt = date.date
        }
        
        earningsPerHour = try values.decodeIfPresent(Earnings.self, forKey: .earningsPerHour)
        jobDescription = try values.decodeIfPresent(JobDescription.self, forKey: .jobDescription)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
    }

}
