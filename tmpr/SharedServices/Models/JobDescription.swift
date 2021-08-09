//
//  JobDescription.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation

class JobDescription: Codable, Equatable {
    var id: String!
    var title: String?
    var project: Project?
    var reportAddress: Address?
    
    init(id: String, title: String?, project: Project?, reportAddress: Address?) {
        self.id = id
        self.title = title
        self.project = project
        self.reportAddress = reportAddress
    }
    
    static func == (lhs: JobDescription, rhs: JobDescription) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.project == rhs.project &&
            lhs.reportAddress == rhs.reportAddress
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case project
        case reportAddress = "report_at_address"
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        project = try values.decodeIfPresent(Project.self, forKey: .project)
        reportAddress = try values.decodeIfPresent(Address.self, forKey: .reportAddress)
    }

}
