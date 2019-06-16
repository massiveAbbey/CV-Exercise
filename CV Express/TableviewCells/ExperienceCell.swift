//
//  ExperienceCell.swift
//  CV Express
//
//  Created by Abbey Ola on 16/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class ExperienceCell: UITableViewCell {

    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .left
        return label
    }()

    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .left
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(jobTitleLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(dateLabel)


        jobTitleLabel.easy.layout(
            Top(8),
            Left(16),
            Right(16))

        companyLabel.easy.layout(
            Top(4).to(jobTitleLabel),
            Left(16),
            Right(16))

        dateLabel.easy.layout(
            Top(4).to(companyLabel),
            Left(16),
            Right(16))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

