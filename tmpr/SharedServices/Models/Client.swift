//
//  Client.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class Client: Codable, Equatable {
    var id: String?
    var name: String?
    var links: Links?
    
    init(id: String?, name: String?, links: Links?) {
        self.id = id
        self.name = name
        self.links = links
    }
    
    static func == (lhs: Client, rhs: Client) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.links == rhs.links
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case links
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }

}
