//
//  Profile.swift
//  CV Express
//
//  Created by Abbey Ola on 13/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation

struct Experience {
    var company: String
    var jobTitle: String
    var startDate: String
    var endDate: String
    var jobDescription: String

    init(company: String, jobTitle: String, startDate: String, endDate: String, jobDescription: String) {
        self.company = company
        self.jobTitle = jobTitle
        self.endDate = endDate
        self.startDate = startDate
        self.jobDescription = jobDescription
    }
}

extension Experience: Codable {
    enum ExperinceCodingKeys: String, CodingKey {
        case company
        case jobTitle
        case startDate
        case endDate
        case jobDescription
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExperinceCodingKeys.self)
        let company = try container.decode(String.self, forKey: .company)
        let jobTitle = try container.decode(String.self, forKey: .jobTitle)
        let startDate = try container.decode(String.self, forKey: .startDate)
        let endDate = try container.decode(String.self, forKey: .endDate)
        let jobDescription = try container.decode((String.self), forKey: .jobDescription)

        self.init(company: company, jobTitle: jobTitle, startDate: startDate, endDate: endDate, jobDescription: jobDescription )
    }
}
