//
//  CV.swift
//  CV Express
//
//  Created by Abbey Ola on 13/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation
import Alamofire

struct CV {
    var name: String
    var title: String
    var cover: String
    var phone: Int
    var address: String
    var pictureUrl: String
    var education: [Education]
    var experience: [Experience]
    var hobbbies: [String]

    init(name: String, title: String, cover: String, phone: Int, address: String, pictureUrl: String, education: [Education], experience: [Experience], hobbies: [String]) {
        self.name = name
        self.title = title
        self.cover = cover
        self.phone = phone
        self.address = address
        self.pictureUrl = pictureUrl
        self.education = education
        self.experience = experience
        self.hobbbies = hobbies
    }
}

extension CV: Codable {
    enum CVCodingKeys: String, CodingKey {
        case name
        case title
        case cover
        case phone
        case address
        case pictureUrl
        case education
        case experience
        case hobbies
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CVCodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let title = try container.decode(String.self, forKey: .title)
        let cover = try container.decode(String.self, forKey: .cover)
        let address = try container.decode(String.self, forKey: .address)
        let pictureUrl = try container.decode(String.self, forKey: .pictureUrl)
        let phone = try container.decode(Int.self, forKey: .phone)
        let education = try container.decode([Education].self, forKey: .education)
        let experience = try container.decode([Experience].self, forKey: .experience)
        let hobbies = try container.decode([String].self, forKey: .hobbies)

        self.init(name: name, title: title, cover: cover, phone: phone, address: address, pictureUrl: pictureUrl, education: education, experience: experience, hobbies: hobbies)
    }
}
