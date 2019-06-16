//
//  Education.swift
//  CV Express
//
//  Created by Abbey Ola on 13/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation

struct Education {
    var school: String
    var degree: String
    var major: String
    var year: Int

    init(school: String, degree: String, major: String, year: Int) {
        self.school = school
        self.degree = degree
        self.major = major
        self.year = year
    }
}

extension Education: Codable {
    enum EducationCodingKeys: String, CodingKey {
        case school
        case degree
        case major
        case year
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EducationCodingKeys.self)
        let school = try container.decode(String.self, forKey: .school)
        let degree = try container.decode(String.self, forKey: .degree)
        let major = try container.decode(String.self, forKey: .major)
        let year = try container.decode(Int.self, forKey: .year)

        self.init(school: school, degree: degree, major: major, year: year)
    }
}
