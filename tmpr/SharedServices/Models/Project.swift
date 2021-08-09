//
//  Project.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class Project: Codable, Equatable {
    var id: String?
    var name: String?
    var client: Client?
    
    init(id: String?, name: String?, client: Client?) {
        self.id = id
        self.name = name
        self.client = client
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.client == rhs.client
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case client
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        client = try values.decodeIfPresent(Client.self, forKey: .client)
    }

}
