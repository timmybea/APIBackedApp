//
//  JSONContainer.swift
//  APIBackedApp
//
//  Created by Tim Beals on 2018-09-24.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation

struct JSONContainer : Decodable {
    
    let people: [Person]
    
    enum ContainerKeys: String, CodingKey {
        case person = "person"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        
        var p = [Person]()
        
        if let people = try container.decodeIfPresent([Person].self, forKey: .person) {
            p = people
        }
        
        self.init(people: p)
    }
    
    init(people: [Person]) {
        self.people = people
    }
    
}
