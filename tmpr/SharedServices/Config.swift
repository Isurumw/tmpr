//
//  Config.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation

class Config {
    
    static private let base: String = "https://temper.works/api/"
    
    static var baseUrl: String {
        get {
            return "\(base)v3/"
        }
    }
    
}
