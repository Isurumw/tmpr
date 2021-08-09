//
//  Links.swift
//  tmpr
//
//  Created by Isuru on 2021-08-07.
//

import Foundation

class Links: Codable, Equatable {
    var heroImage: URL?
    var thumbImage: URL?
    
    init(heroImage: URL?, thumbImage: URL?) {
        self.heroImage = heroImage
        self.thumbImage = thumbImage
    }
    
    static func == (lhs: Links, rhs: Links) -> Bool {
        return lhs.heroImage == rhs.heroImage && lhs.thumbImage == rhs.thumbImage
    }
    
    enum CodingKeys: String, CodingKey {
        case heroImage = "hero_image"
        case thumbImage = "thumb_image"
    }
    
    // Encodable protocol methods
    
    public func encode(to encoder: Encoder) throws { }
    
    // Decodable protocol methods
    
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let urlString = try values.decodeIfPresent(String.self, forKey: .heroImage) {
            heroImage = URL(string: urlString)
        }
        if let urlString = try values.decodeIfPresent(String.self, forKey: .thumbImage) {
            thumbImage = URL(string: urlString)
        }
    }

}
