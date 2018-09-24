//
//  Person.swift
//  APIBackedApp
//
//  Created by Tim Beals on 2018-09-24.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

struct Person : Decodable {
    
    static var personData = [Person]()
    
    var email: URL
    var firstName: String
    var id: String
    var lastName: String
    var imageEndPoint: String
    
    enum PersonKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case imageEndPoint = "image_end_point"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let firstName = try container.decode(String.self, forKey: .firstName)
        let lastName = try container.decode(String.self, forKey: .lastName)
        let email = try container.decode(URL.self, forKey: .email)
        let imageEndPoint = try container.decode(String.self, forKey: .imageEndPoint)
        
        self.init(id: id, firstName: firstName, lastName: lastName, email: email, imageEndPoint: imageEndPoint)
    }
    
    init(id: String, firstName: String, lastName: String, email: URL, imageEndPoint: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.imageEndPoint = imageEndPoint
        
        self.cacheImage()
    }
    
    static func getPeople(from json: Data) -> [Person] {
        
        if let payload = try? JSONDecoder().decode(JSONContainer.self, from: json) {
            self.personData = payload.people
            return self.personData
        } else {
            print("couldn't create payload")
            return []
        }
    }
    
}

extension Person : CustomStringConvertible {
    
    var description: String {
        return "My name is \(firstName) \(lastName). My email is \(email)"
    }
    
}

//MARK: Private methods
extension Person {

    private func cacheImage() {
        UIImage.cacheImage(from: self.imageEndPoint) { (_) in  }
    }

}
